 # Data Science homework and project

###### tags:  `109上` `R language` `data science` `courses` `Statistics` 

>Teacher's website for the class : http://misg.stat.nctu.edu.tw/hslu/course/DataScience.htm
> This note record and share the materials of the [Introduction to Data Science](https://timetable.nycu.edu.tw/?r=main/crsoutline&Acy=107&Sem=1&CrsNo=5404&lang=zh-tw) course and the copyright of these materials belong to Distinguished Professor [Henry Horng-Shing Lu](http://misg.stat.nycu.edu.tw/)



## :memo: Homework 

### Quick views : 

| HW | Link  | Grades |
| ------------ |:-------- |:-------- |
| 1   | [:link:][1]   | 90 |
| 2   | [:link:][2]   | 88 |
| 3   | [:link:][3]   | 83 |
| 4   | [:link:][4]   | 86 |
| 5   | [:link:][5]   | 91 |
| 6   | [:link:][6]   | 86 |
| 7   | [:link:][7]   | 88 |

[1]: https://hackmd.io/8q99COY1SdC_av67J3BXKw
[2]: https://github.com/imyungchu/Data-Science-homework-and-project/tree/main/HW2
[3]: https://github.com/imyungchu/Data-Science-homework-and-project/tree/main/HW3
[4]: https://github.com/imyungchu/Data-Science-homework-and-project/tree/main/HW4
[5]: https://github.com/imyungchu/Data-Science-homework-and-project/tree/main/HW5
[6]:https://github.com/imyungchu/Data-Science-homework-and-project/tree/main/HW6
[7]:https://github.com/imyungchu/Data-Science-homework-and-project/tree/main/HW7

 
 
### Detail requirements of homeworks
##### All of the homework follow by Homework 1 requiremwnts and plans
- Find at least one data set that you plan to study for your future homework and final project.
- Explain the features in your data set.
- Discuss possible problems you plan to investigate based on the data sets you select.
- Possible source of open data: [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets.php)

###### tags: `數據科學概論作業` 


## **Topic : Forecast the rental demand for bicycle-sharing transportation systems**  :memo:  共享單車需求預測  

![](https://i.imgur.com/yqH5lfQ.jpg)

### **Step 1: Find at least one data set that you plan to study for your  future homework and final project.  找到想研究的資料**

#### A. Online Kaggle's **integrated** database.  用Kaggle的資料

-  Use the data that was pre-organized by **Kaggle**. : [Bike Sharing in Washington D.C. Dataset](https://www.kaggle.com/marklvl/bike-sharing-dataset)
-  Cotain all the factors that might affect the demand of bike sharing system **in 2011 and 2012**. 
-  Be able to **compare the outcome** of prediction with other method in Kaggle.

#### Pros and Cons  優缺點 : 

* 優 : 已經整理好且有其他機器學習預測方法可供比較，也有開源程式碼可參考資料處理方式
* 缺 : 只有2011和2012兩年的每小時或每天資料，沒有近幾年資訊，可能與實際狀況有落差

> 為什麼選擇這個資料做研究 ?
>Bike sharing systems are a new generation of traditional bike rentals where the whole process from membership, rental and return back has become automatic. Through these systems, user is able to easily rent a bike from a particular position and return back to another position. Currently, there are about over 500 bike-sharing programs around the world which are composed of over 500 thousands bicycles. Today, there exists great interest in these systems due to their important role in traffic, environmental and health issues.

###### tags: `kaggle` `data set` 

#### B. **Collect** all factors from different database 自己蒐集資料
:bike: [**Capital Bikeshare's** Open source](https://www.capitalbikeshare.com/system-data)
:book: [Holiday schedule](http://dchr.dc.gov/page/holiday-schedule)
:sun_small_cloud: [weather information](http://www.freemeteo.com)
-  Use the newest data for forecasting.
-  Contain more than  three dimension data.
-  Hard to integrated all factors in a file.

#### Pros and Cons  優缺點 : 

* 優 : 可以比較最近幾年的資訊，也可實際應用於預測
* 缺 : 資料蒐集及資料前處理較複雜，也沒有其他解法可以參照比較

### **Step 2: Explain the features in your data set.**
>資料特徵說明
>This dataset contains the hourly and daily count of rental bikes between years 2011 and 2012 in Capital bikeshare system in Washington, DC with the corresponding weather and seasonal information.

```python=1
#feature extraction
features = ["season","yr","mnth","holiday","weekday","workingday","weathersit","temp","hum","windspeed", "casual", "registered"]

X = df[features]
y = df["cnt"] #count of total rental bikes including both casual and registered
```

#### Features List ( 影響共享單車需求的因素 )

- [x]  天氣 weathersit  :bulb:天氣越好/壞 ➜ 增加/降低騎乘需求
1: Clear, Few clouds, Partly cloudy, Partly cloudy
2: Mist + Cloudy, Mist + Broken clouds, Mist + Few clouds, Mist
3: Light Snow, Light Rain + Thunderstorm + Scattered clouds, Light Rain + Scattered clouds
4: Heavy Rain + Ice Pallets + Thunderstorm + Mist, Snow + Fog
- [x]  季節 Season :bulb:春秋舒服/夏天太熱、冬天太冷 ➜ 增加/降低騎乘需求
( 1 : springer, 2 : summer, 3 : fall, 4 : winter ) 
- [x]  **溫度/體感溫度 temp/atemp**  :bulb:適溫/太熱、太冷 ➜ 增加/降低騎乘需求
Normalized **temperature/feeling temperature** in Celsius. 
The values are derived via  $$ (t-tmin) \over (tmax-tmin) $$ where tmin=-8/-16, t_max=+39/+50 (only in hourly scale)

- [x]  相對溼度 hum  :bulb: 適當濕度/太濕、太乾 ➜ 增加/降低騎乘需求
Normalized humidity. The values are divided to 100 (max)
- [x]  風速 windspeed :bulb: 風速小/風速大 ➜ 增加/降低騎乘需求
 Normalized wind speed. The values are divided to 67 (max)
- [x]  租借人是否是會員 :bulb: 會員/非會員 ➜ 增加/降低騎乘需求
casual: count of casual users
registered: count of registered users
cnt: count of total rental bikes including both casual and registered
- [x]  時間/年/月/日/即時 :bulb: 以長時間大量資料整理出該需求週期性變化
instant: Record index
dteday: Date
yr: Year (0: 2011, 1:2012)
mnth: Month (1 to 12)
hr: Hour (0 to 23)
- [x]  節日/假日/工作日 :bulb: 工作日/平日 ➜ 騎乘需求有不同起始值
holiday: weather day is holiday or not (extracted from Holiday Schedule)
weekday: Day of the week
workingday: If day is neither weekend nor holiday is 1, otherwise is 0.






### **Step 3: Discuss possible problems you plan to investigate based on the data sets you select.**

>未來可以研究的方向 : 更精準有效的共享單車需求預測或甚至進行貨車再配送平衡站點單車數量
>Apart from interesting real-world applications of bike sharing systems, the characteristics of data being generated by these systems make them attractive for the research. Opposed to other transport services such as bus or subway, **the duration of travel, departure and arrival position** is explicitly recorded in these systems. **This feature turns bike sharing system into a virtual sensor network** that can be used for sensing mobility in the city. Hence, it is expected that most of important events in the city could be detected via monitoring these data.



![](https://i.imgur.com/kqcqVd0.jpg)
![](https://i.imgur.com/zWSnFeG.jpg)

:bulb: **Hint:** 可藉由預測出的結果與其他方法之預測準確度做比較 ( 例如 : 機器學習vs線性回歸 )  或甚至 進一步進行貨車再配送 實際解決單車分配不均的問題


 **Source of open data :**
- :key: [Kaggle's data set for bicke sharing](https://www.kaggle.com/marklvl/bike-sharing-dataset)
- :bike: [**Capital Bikeshare's** Open source](https://www.capitalbikeshare.com/system-data)
- :book: [Holiday schedule](http://dchr.dc.gov/page/holiday-schedule)
- :sun_small_cloud: [weather information](http://www.freemeteo.com)

:pushpin: **Want to learn more about me ? ➜** [Click here to visit My website](https://imyungchu.github.io/) 

   



## :computer: Term Project  

comparing the accuracy of five methods to predict the number of sharing bike with whether factors, as shown in the following pictures :

#### Comparison of the model performance 


| model (Use R language to implement) | accuracy |
| ------------------------------------| -------- |
| 1. Multiple linear regression   | 0.8196657    |
| 2. Support Vector Regrssion      | 0.8242527 |
| 3. Neural Network                | 0.8536584 |
| 4. Random Forest Regression     |  0.907943 |
| 5. eXtreme Gradient Boosting    |  0.9632193|
-  neural network
![](https://i.imgur.com/KM3Rr3b.jpg)

> ### Reference
> - 支持向量迴歸(Support Vector Regression)
> https://medium.com/r-%E8%AA%9E%E8%A8%80%E8%87%AA%E5%AD%B8%E7%B3%BB%E5%88%97/r%E8%AA%9E%E8%A8%80%E8%87%AA%E5%AD%B8%E6%97%A5%E8%A8%98-20-%E6%A9%9F%E5%99%A8%E5%AD%B8%E7%BF%92-%E4%B8%80-%E6%94%AF%E6%8C%81%E5%90%91%E9%87%8F%E8%BF%B4%E6%AD%B8-support-vector-regression-30cd834a918
> - 隨機森林(Random Forest)
> https://medium.com/chung-yi/ml%E5%85%A5%E9%96%80-%E5%8D%81%E4%B8%83-%E9%9A%A8%E6%A9%9F%E6%A3%AE%E6%9E%97-random-forest-6afc24871857
> - 神經網路
> https://www.geeksforgeeks.org/how-neural-networks-are-used-for-regression-in-r-program
> ming/
> - 機器學習常勝軍 - XGBoost
> https://ithelp.ithome.com.tw/articles/10273094
> https://www.datatechnotes.com/2020/08/regression-example-with-xgboost-in-r.html
> - 資料前處理( Label encoding、 One hot encoding and frequency encoding)
> https://medium.com/@PatHuang/%E5%88%9D%E5%AD%B8python%E6%89%8B%E8%A8%98-3-%E8%B3%87%E6%96%99%E5%89%8D%E8%99%95%E7%90%86-label-encoding-one-hot-encoding-85c
> 983d63f87

- Watch MORE of my projects ➜ [My GitHub repositories](https://github.com/imyungchu?tab=repositories)

