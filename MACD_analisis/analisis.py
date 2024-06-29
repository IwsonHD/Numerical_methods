if __name__ == '__main__':

    import pandas as pd
    import matplotlib.pyplot as plt
    from funcs import MACD_income, calc_MACD_SIGNAL
    
    #orlen 2011-2015
    whole_data = pd.read_csv('pkn_d(2).csv')
    #orlen 1999-2003
    whole_data2 = pd.read_csv('pkn_d.csv')


    #MACD for a period of 1000 days Orlen(2011 - 2014)
    data_1000_days = whole_data['Close'].head(1000)
    MACD_1000, SIGNAL_1000 = calc_MACD_SIGNAL(data_1000_days)
    relative_income_1000, absolute_income_1000,final_balance_1000, balance_history_1000, counter_1000, signals_1000 = MACD_income(data_1000_days, MACD_1000, SIGNAL_1000, 1000)

    #MACD for a period of 50 days Orlen(2011)
    data_50_days = whole_data['Close'].head(50)
    MACD_50, SIGNAL_50 = calc_MACD_SIGNAL(data_50_days)
    relative_income_50, absolute_income_50, final_balance_50, balance_history_50, counter_50, signals_50 = MACD_income(data_50_days, MACD_50, SIGNAL_50,1000)
    

    #MACD for a period of 1000 days Orlen(1999 - 2002)
    data_1000_days2 = whole_data2['Close'].head(1000)
    MACD_10002, SIGNAL_10002 = calc_MACD_SIGNAL(data_1000_days2)
    relative_income_10002, absolute_income_10002,final_balance_10002, balance_history_10002, counter_10002, signals_10002 = MACD_income(data_1000_days2, MACD_10002, SIGNAL_10002, 1000)

    #MACD for a period of 50 days Orlen(1999 - 2002)
    data_50_days2 = whole_data2['Close'][50:100]
    MACD_502, SIGNAL_502 = calc_MACD_SIGNAL(data_50_days2)
    relative_income_502, absolute_income_502,final_balance_502, balance_history_502, counter_502, signals_502 = MACD_income(data_50_days2, MACD_502, SIGNAL_502, 1000)


    #plots for MACD for 1000 days including stock prices, MACD and SIGNAL and income using the macd method
    plt.figure(figsize=(14,7))
    plt.title('Stock prices of Orlen(2011 - 2014) for 1000 days')
    plt.plot(data_1000_days)
    plt.xlabel('Day')
    plt.ylabel('Stock value[$]')
    plt.savefig('Stock_prices_1000_days(2011-2014).png')
    plt.show()
    

    plt.figure(figsize=(14,7))
    plt.title('MACD and SIGNAL plot of Orlen(2011 - 2014) for 1000 days')
    plt.plot(MACD_1000, label='MACD', color='blue')
    plt.plot(SIGNAL_1000, label='SIGNAL', color='red')
    plt.xlabel('Day')
    plt.ylabel('Value')
    plt.legend()
    plt.savefig('MACD_and_signal_1000_days(2011-2014).png')
    plt.show()

    plt.figure(figsize=(14,7))
    plt.title('Balance history of Orlen(2011 - 2014) for 1000 days')
    plt.plot(balance_history_1000)
    plt.xlabel('Day')
    plt.ylabel('Balance')
    plt.savefig('Balance_history_1000_daysOrlen(2011-2014).png')
    plt.show()

    print(relative_income_1000, absolute_income_1000,final_balance_1000,counter_1000)

    #plots for MACD for 50 days including stock prices, MACD and SIGNAL and income using the macd method
    plt.figure(figsize=(14,7))
    plt.title('Stock prices of Orlen(2011) for 50 days')
    plt.plot(data_50_days)
    plt.xlabel('Day')
    plt.ylabel('Stock value[$]')
    plt.savefig('Stock_prices_50_daysOrlen(2011).png')
    plt.show()
    

    plt.figure(figsize=(14,7))
    plt.title('MACD and SIGNAL plot of Orlen(2011) for 50 days')
    plt.plot(MACD_50, label='MACD', color='blue')
    plt.plot(SIGNAL_50, label='SIGNAL', color='red')
    plt.xlabel('Day')
    plt.ylabel('Value')
    plt.legend()
    plt.savefig('MACD_and_signal_50_daysOrlen(2011).png')
    plt.show()

    plt.figure(figsize=(14,7))
    plt.title('Balance history of Orlen(2011) for 50 days')
    plt.plot(balance_history_50)
    plt.xlabel('Day')
    plt.ylabel('Balance')
    plt.savefig('Balance_history_50_days_Orlen(11).png')
    plt.show()

    print(relative_income_50, absolute_income_50,final_balance_50,counter_50)


    plt.figure(figsize=(14,7))
    plt.title('Sale points of Orlen(2011) for 50 days')
    plt.plot(data_50_days)
    blb_added = False
    slb_added = False
    for i in range(len(signals_50)):
        if signals_50[i] == -1:
            if not blb_added:
                plt.scatter(i, data_50_days.iloc[i], color='red', s=40, label='Sell')
                blb_added = True
            else:
                plt.scatter(i, data_50_days.iloc[i], color='red', s=40)
        elif signals_50[i] == 1:
            if not slb_added:
                plt.scatter(i,data_50_days.iloc[i], color='green', s=40, label='Buy')
                slb_added = True
            else:
                plt.scatter(i, data_50_days.iloc[i], color='green', s=40,)
    plt.xlabel('Day')
    plt.ylabel('Stock value[$]')
    plt.legend()
    plt.savefig('Stock_sales_days_Orlen(2011).png')
    plt.show()


     #plots for MACD for 1000 days including stock prices, MACD and SIGNAL and income using the macd method
    plt.figure(figsize=(14,7))
    plt.title('Stock prices of Orlen(1999 - 2002) for 1000 days')
    plt.plot(data_1000_days2)
    plt.xlabel('Day')
    plt.ylabel('Stock value[$]')
    plt.savefig('Stock_prices_1000_days_Orlen(1999-2002).png')
    plt.show()
    

    plt.figure(figsize=(14,7))
    plt.title('MACD and SIGNAL plot of Orlen(1999 - 2002) for 1000 days')
    plt.plot(MACD_10002, label='MACD', color='blue')
    plt.plot(SIGNAL_10002, label='SIGNAL', color='red')
    plt.xlabel('Day')
    plt.ylabel('Value')
    plt.legend()
    plt.savefig('MACD_and_signal_1000_days(1999-2002).png')
    plt.show()

    plt.figure(figsize=(14,7))
    plt.title('Balance history of Orlen(1999 - 2002) for 1000 days')
    plt.plot(balance_history_10002)
    plt.xlabel('Day')
    plt.ylabel('Balance')
    plt.savefig('Balance_history_1000_days_of_Orlen(1999-2002).png')
    plt.show()

    print(relative_income_10002, absolute_income_10002,final_balance_10002,counter_10002)

    #plots for MACD for 1000 days including stock prices, MACD and SIGNAL and income using the macd method
    plt.figure(figsize=(14,7))
    plt.title('Stock prices of Orlen(1999) for 50 days')
    plt.plot(data_50_days2)
    plt.xlabel('Day')
    plt.ylabel('Stock value[$]')
    plt.savefig('Stock_prices_50_days_Orlen(1999).png')
    plt.show()
    

    plt.figure(figsize=(14,7))
    plt.title('MACD and SIGNAL plot of Orlen(1999) for 50 days')
    plt.plot(MACD_502, label='MACD', color='blue')
    plt.plot(SIGNAL_502, label='SIGNAL', color='red')
    plt.xlabel('Day')
    plt.ylabel('Value')
    plt.legend()
    plt.savefig('MACD_and_signal_50_days(1999).png')
    plt.show()

    plt.figure(figsize=(14,7))
    plt.title('Balance history of Orlen(1999) for 50 days')
    plt.plot(balance_history_502)
    plt.xlabel('Day')
    plt.ylabel('Balance')
    plt.savefig('Balance_history_50_days_of_Orlen(1999).png')
    plt.show()

    print(relative_income_502, absolute_income_502,final_balance_502,counter_502)

    plt.figure(figsize=(14,7))
    plt.title('Sale points of Orlen(1999) for 50 days')
    plt.plot(data_50_days2)
    blb_added2 = False
    slb_added2 = False
    for i in range(len(signals_502)):
        if signals_502[i] == -1:
            if not blb_added2:
                plt.scatter(i + 50, data_50_days2.iloc[i], color='red', s=40, label='Sell')
                blb_added2 = True
            else:
                plt.scatter(i + 50, data_50_days2.iloc[i], color='red', s=40)
        elif signals_502[i] == 1:
            if not slb_added2:
                plt.scatter(i + 50,data_50_days2.iloc[i], color='green', s=40, label='Buy')
                slb_added2 = True
            else:
                plt.scatter(i + 50, data_50_days2.iloc[i], color='green', s=40,)
    plt.xlabel('Day')
    plt.ylabel('Stock value[$]')
    plt.legend()
    plt.savefig('Stock_sales_days_Orlen(1999).png')
    plt.show()