from typing import Union,List,Tuple
import pandas as pd

def calc_emas(data: Union[pd.Series, List[float]], period: int)->pd.Series:
    alfa = 2 / (period + 1)
    emas = pd.Series()
    for i in range(len(data)):
        curr_ema = 0
        for j in range(period):
            if i-j >= 0:
                curr_ema += data.iloc[i-j] * (1-alfa)**j
        curr_ema /= sum([(1 - alfa)**x for x in range(min(i+1, period))])
        emas[i] = curr_ema
    return emas

def calc_MACD_SIGNAL(data: pd.Series):
    emas12 = calc_emas(data, 12)
    emas26 = calc_emas(data, 26)
    MACD = emas12 - emas26
    SIGNAL = calc_emas(MACD, 9)
    return MACD, SIGNAL

def MACD_income(data: pd.Series,
                macd:pd.Series,
                singal:pd.Series,
                initStocks:int = 1000)->Tuple[float,float,float,pd.Series,float,List[int]]:
    
    delta = macd - singal
    curr_balance = 0
    stocks_owned = initStocks
    balance_history = pd.Series()
    counter = 0
    sell_buy_points = []
    for i in range(1, len(delta)):
        counter = i
        if delta[i-1] < 0 and delta[i] > 0 and curr_balance != 0:
            stocks_owned = curr_balance / data.iloc[i]
            balance_history[i] = stocks_owned * data.iloc[i]
            curr_balance = 0
            sell_buy_points.append(1)
            
        elif delta[i-1] > 0 and delta[i] < 0 and stocks_owned != 0:
            curr_balance = stocks_owned * data.iloc[i]
            balance_history[i] = curr_balance
            stocks_owned = 0
            sell_buy_points.append(-1)
        else:
            sell_buy_points.append(0)
    if stocks_owned != 0:
        curr_balance = stocks_owned * data.iloc[-1]
        balance_history[counter + 1] = curr_balance

    return balance_history.iloc[-1]/balance_history.iloc[0], balance_history.iloc[-1] - balance_history.iloc[0], curr_balance, balance_history, balance_history.iloc[0], sell_buy_points  

