## Activity Chooser App

---

**Activity Chooser App**s core group is people who have trouble deciding what to do in their free time. User can specify what he likes to do and how much time he has. The app will suggest the best activity.

---

## Screens (with instruction)
- **Home screen** - on this screen user can view the list of activities, and check activities to edit/delete/mark as done. User can also change the page to **Add new activity**, **Edit activity**, or **Tell me what to do** by swiping the activity on the list to the right.
- **Add new activity** - user can fill out the form to add a new activity. The user has to provide such data as name, duration, type (chosen from the list), and rating. To make an activity without time limits (it will take part in each draw), the user has to set its duration to 0.
- **Edit activity** - user can fill out the form to edit existing activity. User can change such data as name, duration, type (chosen from the list), and rating.
- **Tell me what to do form** - user can fill out the form to provide such data as the time he has and the type of activity he wants to do, so the app will be able to find the match. It will go to the **Selected activity** page. If user doesn't have time limits, he should set duration to 0.
- **Selected activity** - page with information about the activity that has been chosen. User can go back to the main screen or reroll with the same requirements.

## User stories
- User can **view a list** of activities.
- User can **add** new activity.
- User can **edit** existing activity.
- User can specify the type of activity (some **tags** such as book, movie, sport, etc).
- User can **get random activity** based on free time and the preferred type guidelines.
- User can **rate** activities which will set the priority.
- User can **delete** an activity.
- User can **mark activity as done** - it will not take part in the draw.
- User will **not loose data** after exiting app.
- User **can filter** activities.

## Integration and database schema
The application is using device's storage to save the data. The process is provided with **hive**. A list of activities is stored as a list of adapted-to-hive class **Activity** that contains important data. A list of activities is stored temporarily in a field of class **ActivityDatabase**. All changes are being made on this list, then the actual database is updated.

