# How it's started?
For a long time I was convinced that I'm able to maintain good physical health without any activity tracking. A lot had happened since then. I have been interested in sport since I was a child, but I started realizing, the more I'm growing up the more my daily routine changes, including responsibilities, hobbys, ideas for life and so on. I came in to a conclusion that if I want improve or maintain the current state of the health (some process in general) or valide the ideas, you need to gather some data to understand at wchich point exacly I am. After that I can aggregate it, analyse, make hipothesis, validate an ideas or draw conclusions. Just like in personal finances.

Despite innate skepticism and thank to curiousness about new technologies I joined the fitness trackers journey. First of all, I tried Google Fit App but it involved carrying smartphone everywhere. In the meantime, I couldn't adopt any fancy smart digital watch which needed a re-charge every few days in order for them to tell the correct time.  

So, after quite a long research, Garmin was a choice. After few days something clicked. The Garmin app did a pretty good job of capturing and showcasing the data, but personally, other brands like Huawei or Samsung did it in more consumable format. (but I must admit the Garmin is targetting their products for different market segment).  

<p align="center">
  <img width="700" height="350" src="https://github.com/patrykrostkowski/Garmin_Data_ETL_Project/blob/main/0.Raw_images/Health%20Dashboards.png">
</p>  

> Source: https://blog.essentialdesign.com/rating-the-user-experience-of-wearables [access 10/9/2023]  


Intrigued by the sheer variety of data points Garmin could capture, after few months I was urge to see what lies hidden behind the charts and get more information which I couldn't find there. Particulary I was curious about:
- How active are my days? Do I spend a considerable amount of time being sedentary?
- How does this data vary on weekdays vs weekends?
- What factors contribute to the highest calorie burn?
- Which exercises are the best and easiest way to achieve my daily goals?
- Have I been following a steady sleep schedule? What factors influence it? Can I spot some patterns?
- Understand the sleep stages and find out what it takes to get a better deep sleep.
- What is the impact of a stress or activities on sleep?

---
# Getting the Data 
As mentioned in [README](https://github.com/patrykrostkowski/Garmin_Data_ETL_Project/tree/main#readme), I downloaded and parsed data via [GarminDB](https://github.com/tcgoetz/GarminDB) into SQLite databases.  
I've created linked servers in SSMS. After that, I created procedure called [`dbo.p_create_src_views`](https://github.com/patrykrostkowski/Garmin_Data_ETL_Project/blob/main/2.DBs_Backup/garmin_10102023/dbo.p_create_src_views.StoredProcedure.sql) that creates views dynamically by taking proper schema and table names from `dbo.config`. That process was repeated for 4 databases.  

|TableSchema|SchemaName|IsActive|
|---|---|---|
|daily_summary|src|Y|
|resting_hr|src|Y|
|...|...|...|  

At the end, procedure [`dbo.p_populate_src_tables`](https://github.com/patrykrostkowski/Garmin_Data_ETL_Project/blob/main/2.DBs_Backup/garmin_10102023/dbo.p_populate_src_tables.StoredProcedure.sql) populates staging tables from sql views. For practice, I've recreate summary tables, specially [`dbo.daily_summary`](https://github.com/patrykrostkowski/Garmin_Data_ETL_Project/blob/main/2.DBs_Backup/garmin_10102023/dbo.vw_tbl_daily_summary.View.sql), which was a start point to higher data aggregation.

---
# Activity Analysis
First of all, let's check how my life looks after 240 days of measures. Like other brands, Garmin has some basic daily measures like steps, floors and calories. It also tracks, through the heart rate, how many minutes I spend daily being moderate and very active. At the very beginning I have set up step goal to 7000 and set to recalculate it based on usage (it's called auto step goal). I wanted to see how it behave in compare to fixed number of steps per day. It took only 5-6 days to increased my step goal to 10 000. That meant I doing more than I assumed.

<p align="center">
  <img width="980" height="650" src="https://github.com/patrykrostkowski/Garmin_Data_ETL_Project/blob/main/0.Raw_images/average%20patrick%20day.png">
</p>  

The dashboard suggests I am averaging about 11k steps per day which is quite higher then average according to some [health studies](https://ijbnpa.biomedcentral.com/articles/10.1186/1479-5868-8-79#Sec3) or [meta-analysis](https://pubmed.ncbi.nlm.nih.gov/17911274/), wich estimates around 8000 steps per day as reasonable threshold.  
Big part of burned calories is taken from running, cycling, strength training and football matches. The watch was bought on February, so most data comes from warm season of the year. I'm guessing this numbers can vary after I cover at least one whole year.  

  
But let's look at these numbers in more detail.

## Steps, Active minutes
The graph below shows heatmap of count of steps per hour. The first noticeable pattern is a brighter rectangle, which may lead to a conclusion I could have a sedentary job. Indeed, the hours from 9am to 5pm I spend mostly sitting, so the weekdays are clearly divided into few pieces. 
<p align="center">
  <img width="500" height="500" src="https://github.com/patrykrostkowski/Garmin_Data_ETL_Project/blob/main/0.Raw_images/steps%20over%20week.png">
</p> 
On the other hand, on weekend intentionally I spend more time moving. Across the week, we can see there are some step peaks - on Sunday and some weekdays. Sunday's peak is caused by evening football match, where I can do up to 12 000 'steps' in 90 min. High scores during the week, is probably because I used to come back from work on foot. Speccially on Mondays, when I am falling for the Monday Blues and I have to work this out.

<p align="center">
  <img width="1000" height="350" src="https://github.com/patrykrostkowski/Garmin_Data_ETL_Project/blob/main/0.Raw_images/calories%2C%20activity%20time.png">
</p> 

I'm getting higher step counts on average than my dynamic goal (**11 415** vs **10 831**). This is due to some days, where I beat my goal a lot, e.x. during hiking or very busy day. When I compare a middle values of the data distribution, they are pretty similar (**10 667** vs **10 645**).  

Tuesdays and Thursdays were the days I averaged about 50-60min of strenth training and going to work by bike. Fewer minutes on the rest of the days were due to other things that has to be done (including laziness).  

## Calories burned, Activity types
Analysing the heart rate and amount of calories burned per minute for various Activities shows some interesting findings. I must say it was fun to comparing own data with [Medical Comparative Study](https://pubmed.ncbi.nlm.nih.gov/25162652/), that showns similar calories rate per minute.  

<p align="center">
  <img width="1000" height="250" src="https://github.com/patrykrostkowski/Garmin_Data_ETL_Project/blob/main/0.Raw_images/activity%20heart%20rates%20and%20calories.png">
</p>  

> One note, I my case running means running intervals, up to 50 min, not long distance run.

Just as research shows, heart rate is highly related to amount of calories burned per minute. It is interesting to see that running activities helps me burn the most calories, almost 13 per minute.  
Hmm... I think the calculation is simple: to compensate for a beer, a 10 minute run is what I need. (**standing ovation, handshaking myself**)  

Along with cycling, football is my favourite sport. Again, I would say is a win-win scenario. Crossfit and swimming needs more data to fairly compare with others.
Point to note here is that calories burned should not be the only metric on which these activities can be graded. But, this happens to be the only most understandable measure for people who wants to e.x. loose weight.  
Why it shouldn't be the only one?  
Because by setting our goal based on number of calories or intensity of activity, we ignore how muscles and metabolism reacts on particular stimulus.

<p align="center">
  <img width="800" height="400" src="https://github.com/patrykrostkowski/Garmin_Data_ETL_Project/blob/main/0.Raw_images/heart%20rate%20zones.png">
</p>  

The graph above shows time proportion of my heart rate during specific activities.
Taking into account the number of calories burned per minute and how the body uses energy, I can assume that in order to enjoy eating pizza and not gain fat, the best solution is light interval running over minimum 30-40 min.  

> For more details, here are some articles:  [Scientific elaboration](https://pubmed.ncbi.nlm.nih.gov/19855335/),  [More accessible explanation](https://www.kartamultisport.pl/en/article/heart-rate-zones-what-they-are-and-why-is-it-worth-knowing), [Polish article](https://metime.fit/trenuj-swiadomie-i-efektywnie-spalaj-tkanke-tluszczowa))

It is fascinating that, based on knowledge about our bodies, we can choose how we exercise depending on what we are trying to achieve by being active (assuming we're not doing it just for fun).

## Sleep analysis
After a few years working in shifts, I began to pay attention to the fact that inconsistent sleep affects my mood, metabolism, and cognitive performance. Overall, I had more time for myself and traveled more often, but depending on the time of the day, health has been mixed.  
Normally we spend almost a third of our life in sleeping, thats about 25 years! (how the personal coaches feels about it?)
After I read 'Why We Sleep' by Matthew Walker I could say that it is well spend time (btw. I recommend this book). Knowing how much we owe to sleep, let us to get the most out of it.  

When I change shift job, I appreciate a full night's sleep. The difference was perceptible.  
Reading more on sleep, I find some standard ways which can help achieve a good night sleep.
- Following a relative consistent sleep schedule
- Watch my diet
- Get moving
- Avoid bright/blue light at night before hitting the bed (I'm working on that but funny cat's reels is not helping me to do that)
- Sleep in a cool and dark room
- Getting at-least 6-7 hours of sleep
  
Some assumptions can be reviewed.  
From the graphs below, I found that I was averaging a sleep of almost 7 hours with high deviation in the numbers. Looks alarming. Do I have serious sleeping problem? I wouldn't say that. It just... 
> Note: the charts don't cover all months because sleep data has been recorded regularly from June.

<p align="center">
  <img width="1000" height="370" src="https://github.com/patrykrostkowski/Garmin_Data_ETL_Project/blob/main/0.Raw_images/sleep%20duration%20and%20across%20months.png">
</p>  

**Wedding partys are really fun until you have to count them on both hands.**

Though the average duration was somewhat similar, the overall sleep quality was not the same. On some days, I was feeling good even by attaining 5-6 hours of sleep, while there have been many instances when even after long night, I wasn’t feeling fresh. Apart from bedtime, I found the possible answer by analysing the sleep cycles.  

  
How we feel when we wake up (fresh or with confusional arousal) is also depending on what phase of sleep we were in right before the alarm (disclaimer: waking up during the NREM phase is not recommended unless you like morning headaches). We have no control over it (yet?), but it is fascinating to know.


The pie chart shows that on an average, my body spends just about 18% in Deep sleep, 19% REM and the rest in either light or being slightly awake. 

<p align="center">
  <img width="1000" height="330" src="https://github.com/patrykrostkowski/Garmin_Data_ETL_Project/blob/main/0.Raw_images/sleep%20phases%20proportion%20over%20moths.png">
</p>  
The date-time plot of sleep phases shows that these numbers can very. Survived almost all weddings, my total slee ptime didn't change much, but I'm getting significant higher results in deep and REM sleep. Even I feel that I have more stable sleep schedule it super fun to find an evidence for that.  

The reason I'm pleased for this is [non-REM sleep is ideal for the brain's glymphatic system to “clean” itself of toxins.](https://www.scientificamerican.com/article/deep-sleep-gives-your-brain-a-deep-clean1) 
 
## Life Correlations
sample text  
sleep phases correlation  
activity correlation

---  

# Conclusion
Collecting health data doesn't make you healthy. What matters is what you do with that. If you decide to take a walk to the gym insted of drive by car, because "today I'm sitting all day long writing health article", THAT IS the positive effect of wearing fancy fit tracker. Overall it's about seeking opportunities to stay in touch with your physical body by moving. And include this process into your daily routine.  
Furthermore, it is just fun to getting know yourself better and confronting research results.
