#include<iostream>
#include<vector>
#include<string>
#include<cmath> 
#include<list>
#include<fstream>
#include<chrono>
#include<map>

using namespace std;

class SqrMatrix;

class Vector {
private:
    vector<double> vector_body;
    int size;

public:
    Vector(int size, double init_values = 0.0) : size(size), vector_body(vector<double>(size, init_values)) {}

    void initProjectValues(int f = 3) {
        for (int i = 0; i < size; i++) {
            vector_body[i] = sin((i + 1) * (f + 1));
        }
    }

    void formatPrint() const {
        cout << "[";
        for (int i = 0; i < size; i++) {
            cout << " " << vector_body[i] << " ";
        }
        cout << "]\n";
    }

    void formatLessPrint() const {
        if (size < 10) return;
        cout << "[";
        for (int i = 0; i < 7; ++i) {
            cout << " " << vector_body[i] << " ";
        }
        cout << " ... " << vector_body[size - 1] << "]'\n";
    }

    int getSize() const {
        return size;
    }

    double euclideanNorm() const {
        double out = 0.0;
        for (double x : vector_body) {
            out += x * x;
        }
        return sqrt(out);
    }



    //OPERATORS 
    double& operator[](int i) {
        return vector_body[i];
    }

    double operator[](int i) const {
        return vector_body[i];
    }

    Vector operator+(const Vector& component) const {
        int size = component.getSize();
        Vector outVec(size);
        if (size != this->getSize()) return outVec;

        for (int i = 0; i < size; i++) {
            outVec[i] = vector_body[i] + component[i];
        }

    }

    Vector operator-(const Vector& component) const {
        int size = component.getSize();
        Vector outVec(size);
        if (size != this->getSize()) return outVec;

        for (int i = 0; i < size; i++) {
            outVec[i] = vector_body[i] - component[i];
        }
        return outVec;
    }



    //FRIENDSHIPS
    friend long Jacobi_v2(const Vector& b, const SqrMatrix& A, Vector& x, list<double>& followingResiduals, double& duration_sec, const int iter_cap);
    friend Vector operator*(const SqrMatrix& A,const Vector& b);
    friend long Jacobi(const Vector& b, const SqrMatrix& A, Vector& x);
    friend long Gauss_Seidel(const Vector& b, const SqrMatrix& A, Vector& x, list<double>& followingResiduals, double& duration_sec, const int iter_cap);
    friend long Gauss_Seidel_v2(const Vector& b, const SqrMatrix& A, Vector& x, list<double>& followingResiduals, double& duration_sec, const int iter_cap );
    friend double directLUFactor(const Vector& b, const SqrMatrix& A, Vector& x, double& duration_sec);
};

class SqrMatrix {
private:
    vector<vector<double>> matrix_body;
    int size;

protected:
    //L and U has to be a zero matrix
    void LU_factorization(SqrMatrix& L, SqrMatrix& U) const {
        int size = L.getSize();
        if (size != U.getSize()) return;


        for (int i = 0; i < size; i++) {
            L[i][i] = 1.0;
        }
        for (int i = 0; i < size; ++i) {
            for (int k = i; k < size; ++k) {
                double sum = 0.0;
                for (int j = 0; j < i; ++j) {
                    sum += L[i][j] * U[j][k];
                }
                U[i][k] = matrix_body[i][k] - sum;
            }

            for (int k = i + 1; k < size; ++k) {
                double sum = 0.0;
                for (int j = 0; j < i; ++j) {
                    sum += L[k][j] * U[j][i];
                }
                L[k][i] = (matrix_body[k][i] - sum) / U[i][i];
            }
        }
    }

public:
    SqrMatrix(int size, double init_values = 0.0) :size(size), matrix_body(vector<vector<double>>(size, vector<double>(size, init_values))) {}

    void initProjectValues(int a1 = 5, int a2 = -1, int a3 = -1) {
        for (int i = 0; i < size; i++) { //kolumny
            for (int j = 0; j < size; j++) { //wiersze
                if (i == j) {
                    matrix_body[i][j] = a1;
                    if (i + 1 < size) matrix_body[i + 1][j] = a2;
                    if (j + 1 < size) matrix_body[i][j + 1] = a2;
                    if (i + 2 < size) matrix_body[i + 2][j] = a3;
                    if (j + 2 < size) matrix_body[i][j + 2] = a3;
                }
            }
        }
    }

    
    void formatPrint() const {
        for (int i = 0; i < size; i++) {
            cout << "[";
            for (int j = 0; j < size; j++) {
                cout << " " << matrix_body[i][j] << " ";
            }
            cout << "]\n";
        }
    }


    void formatLessPrint() const {
        if (size < 10) return;

        for (int i = 0; i < 3; ++i) {
            cout << "[";
            for (int j = 0; j < 7; ++j) {
                cout << " " << matrix_body[i][j] << " ";
            }
            cout << " ... " << matrix_body[i][size - 1] << " ]\n";
        }
        for (int i = 0; i < 3; ++i) {
            cout << "[";
            for(int j = 0; j < 9 ;++j){
                cout << " . ";
            }
            cout << "]\n";
        }
        cout << "[";
        for (int i = 0; i < 7; ++i) {
            cout << " " << matrix_body[size - 1][i] << " ";
        }
        cout << " ... " << matrix_body[size - 1][size - 1] << " ]\n";

    }

    int getSize() const {
        return size;
    }





   
    //OPERATORS
    const vector<double>& operator[](int i) const {
        return matrix_body[i];
    }

    vector<double>& operator[](int i) {
        return matrix_body[i];
    }
    
    //FRIENDSHIPS
    friend Vector operator*(const SqrMatrix& A, const Vector& b);
    friend long Jacobi(const Vector& b, const SqrMatrix& A, Vector& x);
    friend long Gauss_Seidel(const Vector& b, const SqrMatrix& A, Vector& x);
    friend double directLUFactor(const Vector& b, const SqrMatrix& A, Vector& x, double& duration_sec);
    friend long Jacobi_v2(const Vector& b, const SqrMatrix& A, Vector& x, list<double>& followingResiduals, double& duration_sec, const int iter_cap);
};

Vector operator*(const SqrMatrix& A, const Vector& b) {
    int size = b.getSize();
    Vector outVec(size);
    if (size != A.getSize()) return outVec;

    for (int i = 0; i < size; ++i) {
        double resultNum = 0;
        for (int j = 0; j < size; ++j) {
            resultNum += A[i][j] * b[j];
        }
        outVec[i] = resultNum;
    }
    return outVec;
}

//returns amount of iterations
long Jacobi(const Vector& b, const SqrMatrix& A, Vector& x, list<double>& followingResiduals, double& duration_sec, const int iter_cap = 1000){
    int size = b.getSize();
    if (A.getSize() != size) return -1;
    double res;
    long iterations = 0;
    auto start = chrono::high_resolution_clock::now();
    do {
        iterations++;
        Vector newx(size);
        for (int i = 0; i < size; ++i) {
            double resNum = b[i];
            for (int j = 0; j < size; ++j) {
                if (i == j) continue;
                resNum -= A[i][j] * x[j];
            }
            newx[i] = resNum / A[i][i];
        }
        x = newx;
        res = ((A * x) - b).euclideanNorm();
        followingResiduals.push_back(res);
        //cout << res<<'\n';
    } while (res > pow(10.0, -9.0) && iterations <= iter_cap);
    
    auto end = chrono::high_resolution_clock::now();
    auto duration = chrono::duration_cast<chrono::milliseconds>(end - start);
    duration_sec = ((double)duration.count()) / 1000;
 
    return iterations;
}

long Jacobi_v2(const Vector& b, const SqrMatrix& A, Vector& x, list<double>& followingResiduals, double& duration_sec, const int iter_cap = 1000) {
    int size = b.getSize();
    if (A.getSize() != size) {
        return -1;
    }

    double res;
    long iterations = 0;
    auto start = chrono::high_resolution_clock::now();
    Vector new_x(size);

    do {
        iterations++;
        for (int i = 0; i < size; ++i) {
            double resNum = b[i];
            for (int j = 0; j < size; ++j) {
                if (j == i) continue;
                resNum -= A[i][j] * x[j];
            }
            new_x[i] = resNum / A[i][i];
        }
        swap(x.vector_body, new_x.vector_body); // Swap instead of copying

        // Calculate residual norm
        Vector residual = (A * x) - b;
        res = residual.euclideanNorm();
        followingResiduals.push_back(res);
    } while (res > pow(10.0, -9.0) && iterations <= iter_cap);

    auto end = chrono::high_resolution_clock::now();
    duration_sec = chrono::duration_cast<chrono::milliseconds>(end - start).count() / 1000.0;

    return iterations;
}






//returns amount of iterations
long Gauss_Seidel(const Vector& b, const SqrMatrix& A, Vector& x, list<double>& followingResiduals, double& duration_sec,const int iter_cap = 1000) {
    int size = b.getSize();
    if (A.getSize() != size) return -1;
    double res;
    long iterations = 0;
    auto start = chrono::high_resolution_clock::now();
    do {
        iterations++;
        Vector newx(size);
        for (int i = 0; i < size; ++i) {
            double resNum = b[i];
            for (int j = 0; j < size; ++j) {
                if (j < i) resNum -= A[i][j] * newx[j];
                else if (j > i) resNum -= A[i][j] * x[j];
            }
            newx[i] = resNum / A[i][i];
        }
        x = newx;
        res = ((A * x) - b).euclideanNorm();
        followingResiduals.push_back(res);
        //cout << res.euclideanNorm()<<'\n';
    } while (res > pow(10.0, -9.0) && iterations <= iter_cap);

    auto end = chrono::high_resolution_clock::now();
    auto duration = chrono::duration_cast<chrono::milliseconds>(end - start);
    duration_sec =((double)duration.count())/1000;
    return iterations;
}

long Gauss_Seidel_v2(const Vector& b, const SqrMatrix& A, Vector& x, list<double>& followingResiduals, double& duration_sec, const int iter_cap = 1000) {
    int size = b.getSize();
    if (A.getSize() != size) {
        return -1;
    }

    double res;
    long iterations = 0;
    auto start = chrono::high_resolution_clock::now();
    Vector new_x(size);

    do {
        iterations++;
        for (int i = 0; i < size; ++i) {
            double resNum = b[i];
            for (int j = 0; j < size; ++j) {
                resNum -= A[i][j] * (x[j] * (j > i) + new_x[j] * (j < i));
            }
            new_x[i] = resNum / A[i][i];
        }
        swap(x.vector_body, new_x.vector_body); 

        
        Vector residual = (A * x) - b;
        res = residual.euclideanNorm();
        followingResiduals.push_back(res);
    } while (res > pow(10.0, -9.0) && iterations <= iter_cap);

    auto end = chrono::high_resolution_clock::now();
    duration_sec = chrono::duration_cast<chrono::milliseconds>(end - start).count() / 1000.0;

    return iterations;
}




//returns residual
double directLUFactor(const Vector& b, const SqrMatrix& A, Vector& x, double& duration_sec){
    int size = b.getSize();
    if (size != A.getSize()) return -1;
    SqrMatrix L(size),U(size);

    auto start = chrono::high_resolution_clock::now();

    A.LU_factorization(L, U);

    Vector y(size);
    for (int i = 0; i < size; ++i) {
        double sum = 0.0;
        for (int j = 0; j < i; ++j) {
            sum += L[i][j] * y[j];
        }
        y[i] = (b[i] - sum) / L[i][i];
    }

    for (int i = size - 1; i >= 0; --i) {
        double sum = 0.0;
        for (int j = i + 1; j < size; ++j) {
            sum += U[i][j] * x[j];
        }
        x[i] = (y[i] - sum) / U[i][i];
    }
    auto end = chrono::high_resolution_clock::now();
    auto duration = chrono::duration_cast<chrono::milliseconds>(end - start);
    duration_sec = ((double)duration.count()) / 1000;
    return ((A * x) - b).euclideanNorm();
}


void printList(list<double> list) {
    for (double x : list) {
        cout << x << '\n';
    }
}

void saveListToFile(const list<double>& list, const string filename) {
    ofstream outputfile(filename);
    if (!outputfile.is_open()) {
        cout << "Cannot open given file" << endl;
        return;
    }
    outputfile << "Following_residuals" << endl;
    for (double element : list) {
        outputfile << element << endl;
    }
    outputfile.close();
}

void saveMapToFile(const map<double, int>& mp, const string filename) {
    ofstream outputfile(filename);
    if (!outputfile.is_open()) {
        cout << "Cannot open given file" << endl;
        return;
    }

    outputfile << "time size" << endl;
    
    for (const auto& element : mp) {
        outputfile << element.first << " " << element.second << endl;
    }

    outputfile.close();
}








int main() {
    //Zadanie A
    const int N = 966;
    SqrMatrix A(N);
    Vector b(N);
    cout << "\n";
    A.initProjectValues(5, -1, -1);
    b.initProjectValues(3);
    A.formatLessPrint();
    cout << "\n";
    b.formatLessPrint();
    cout << "\n";
    ////Zadanie B
    //Vector x_Jacobi(N);
    //Vector x_Gauss_Seidel(N);
    //list<double> following_residuals_Jacobi;
    //list<double> following_residuals_Gauss_Seidel;
    //double time_Jacobi, time_Gauss_Seidel;
    //long iterations_Jacobi = Jacobi_v2(b, A, x_Jacobi, following_residuals_Jacobi,time_Jacobi);
    //long iterations_Gauss_Seidel = Gauss_Seidel_v2(b, A, x_Gauss_Seidel, following_residuals_Gauss_Seidel,time_Gauss_Seidel);
    //saveListToFile(following_residuals_Jacobi, "../following_residuals_Jacobi.txt");
    //saveListToFile(following_residuals_Gauss_Seidel, "../following_residuals_Gauss_Seidel.txt");
    //cout << "Jacobi iterations: " << iterations_Jacobi <<" time: "<< time_Jacobi << endl;
    //cout << "Gauss Seidel iterations: " << iterations_Gauss_Seidel <<" time: "<<time_Gauss_Seidel << endl;

    ////Zadanie C
    //SqrMatrix A_C(N);
    //Vector b_C(N);
    //Vector x_Jacobi_C(N);
    //Vector x_Gauss_Seidel_C(N);
    //A_C.initProjectValues(3, -1, -1);
    //b_C.initProjectValues(3);
    //A_C.formatLessPrint();
    //list<double> following_residuals_Jacobi_C;
    //list<double> following_residuals_Gauss_Seidel_C;
    //double time_Jacobi_C, time_Gauss_Seidel_C;
    //long iterations_Jacobi_C = Jacobi_v2(b_C, A_C,x_Jacobi_C, following_residuals_Jacobi_C, time_Jacobi_C, 1000);
    //long iterations_Gauss_Seidel_C = Gauss_Seidel_v2(b_C, A_C,x_Gauss_Seidel_C, following_residuals_Gauss_Seidel_C, time_Gauss_Seidel_C, 1000);
    //saveListToFile(following_residuals_Jacobi_C, "../following_residuals_Jacobi_C.txt");
    //saveListToFile(following_residuals_Gauss_Seidel_C, "../following_residuals_Gauss_Seidel_C.txt");

    //Zadanie D
    SqrMatrix A_D(N);
    Vector b_D(N);
    Vector x_directLU(N);
    A_D.initProjectValues(3, -1, -1);
    b_D.initProjectValues(3);
    double time_directLU;
    double residual_norm_D = directLUFactor(b_D, A_D, x_directLU, time_directLU);
    cout << endl;
    cout<< "Direct LU decomposition time: " << time_directLU << " residual norm: " << residual_norm_D << endl;
 
    //////Zadanie F
    //int Narray[] = { 100, 500, 1000, 2000, 3000, 4000, 5000, 6000 };
    //map<double,int> Jacobi_times;
    //map<double,int> Gauss_Seidel_times;
    //map<double,int> direct_LU_times;
    //list<double> frJ;
    //list<double> frGS;


    //for (int n : Narray) {
    //    SqrMatrix A_F(n);
    //    Vector b_F(n);
    //    Vector x_Jacobi_F(n);
    //    Vector x_Gauss_Seidel_F(n);
    //    Vector x_direct_LU_F(n);
    //    A_F.initProjectValues();
    //    b_F.initProjectValues();
    //    double time_Jacobi_F, time_Gauss_Seidel_F, time_direct_LU_F = 0;
    //    
    //    long itJ = Jacobi_v2(b_F, A_F, x_Jacobi_F, frJ, time_Jacobi_F);
    //    long itGS = Gauss_Seidel_v2(b_F, A_F, x_Gauss_Seidel_F, frGS, time_Gauss_Seidel_F);
    //    double rnDLU = directLUFactor(b_F, A_F, x_direct_LU_F, time_direct_LU_F);
    //    Jacobi_times[time_Jacobi_F] = n;
    //    Gauss_Seidel_times[time_Gauss_Seidel_F] = n;
    //    direct_LU_times[time_direct_LU_F] = n;
    //    cout << n << endl;
    //}

    //saveMapToFile(Jacobi_times, "../times_Jacobi_F.txt");
    //saveMapToFile(Gauss_Seidel_times, "../times_Gauss_Seidel_F.txt");
    //saveMapToFile(direct_LU_times, "../times_direct_LU_F.txt");



    //TESTS
    //Vector x_Jacobi(N);
    //Vector x_Gauss_Seidel(N);
    //list<double> following_residuals_Jacobi;
    //list<double> following_residuals_Gauss_Seidel;
    //double time_Jacobi, time_Gauss_Seidel;
    //long iterations_Jacobi = Jacobi_v2(b, A, x_Jacobi, following_residuals_Jacobi,time_Jacobi);
    //cout << time_Jacobi << endl;
    //long iterations_Gauss_Seidel = Gauss_Seidel_v2(b, A, x_Gauss_Seidel, following_residuals_Gauss_Seidel,time_Gauss_Seidel);
    //cout << time_Gauss_Seidel << endl;
    //printList(following_residuals_Jacobi);
    //printList(following_residuals_Gauss_Seidel);


    return 0;
}
