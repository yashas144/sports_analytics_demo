# AI-Powered Sports Analytics Platform

A full-stack sports analytics application built to demonstrate how modern web engineering, structured data systems, and AI-ready architecture can come together in a single product.

This project combines a **React frontend**, **Flask backend**, and **MySQL relational database** to deliver an interactive analytics experience for players, teams, matches, and awards. It is designed as a strong foundation for **AI-integrated sports products** such as match outcome prediction, player performance forecasting, anomaly detection, and real-time sports intelligence.

---

## Why this project stands out

This project showcases my ability to build **end-to-end software systems** and position them for **AI integration**:

- Built a **full-stack application** with clear separation between frontend, backend, and database layers
- Developed a **React-based user interface** with protected routes, dashboards, entity views, forms, and history pages
- Created a **Flask REST API** to expose structured sports data from a relational backend
- Integrated a **MySQL database workflow** for querying, serving, and managing sports analytics records
- Designed the platform to evolve into an **AI-powered analytics system** with predictive and recommendation features

This is not just a dashboard. It is a product-oriented foundation for **full-stack engineering with AI integration**.

---

## Project overview

The platform currently supports:

- Player management and browsing
- Team management and browsing
- Match management and browsing
- Player awards tracking
- History and detail views
- Authentication-aware frontend navigation
- Dashboard summaries and ranked views
- API-driven data retrieval from MySQL

The system is structured to support future AI modules such as:

- Match outcome prediction
- Expected player performance forecasting
- Injury impact analysis
- Recommendation systems
- Search and ranking
- Real-time sports intelligence pipelines

---

## Architecture

```text
React Frontend
   |
   |  HTTP / JSON
   v
Flask REST API
   |
   |  SQL Queries
   v
MySQL Database
```

### Frontend
- Built with **React**
- Uses **React Router** for multi-page navigation
- Includes protected routes and authenticated user flow
- Provides entity pages for players, teams, matches, and awards
- Includes dashboard-style views for analytics presentation

### Backend
- Built with **Flask** and **Flask-CORS**
- Exposes REST endpoints for sports entities
- Connects to MySQL using `mysql-connector-python`
- Serializes date fields for API responses
- Provides a health endpoint for backend/database validation

### Database
- Powered by **MySQL**
- Uses structured relational sports data
- Supports entity retrieval across players, teams, matches, and users
- Suitable for future ETL, feature engineering, and analytics pipelines

---

## Current feature set

### 1. Full-stack sports data platform
The application delivers a complete workflow from database to browser:
- MySQL stores the sports records
- Flask fetches and formats the data
- React renders the results in structured tables and views

### 2. Dashboard and analytics-style views
The home page highlights:
- total players
- total teams
- total matches
- total awards
- top players by goals
- top teams by wins

This gives the application an analytics product feel rather than a basic CRUD interface.

### 3. Entity management
The platform includes dedicated pages and flows for:
- Players
- Teams
- Matches
- Player Awards

### 4. History and detail navigation
The system includes detail and history-oriented pages such as:
- Player history
- Team history
- Match history
- Player dashboard

### 5. Auth-aware routing
The frontend includes login/authentication context and protected routes, which makes the platform more aligned with real product architecture.

---

## AI integration vision

This project is intentionally structured as a **sports analytics foundation for AI-powered features**.

### Near-term AI features
- **Match outcome prediction** using historical team and match data
- **Expected player statistics forecasting** using player history and performance trends
- **Player comparison engine** for ranking and scouting use cases
- **Prediction vs. actual analysis** to measure model quality over time
- **Natural-language search** for players, teams, and matches
- **Explainable AI insights** to show why the system made a prediction

### Advanced roadmap
- Real-time match feeds and live analytics
- Injury impact modeling
- Recommendation engine for players, teams, or lineups
- AI-generated game summaries
- RAG-based sports insights over historical match data and reports
- Cloud deployment with model-serving APIs and monitoring

---

## Tech stack

### Frontend
- React
- React Router
- Chart.js
- react-chartjs-2

### Backend
- Flask
- Flask-CORS
- Gunicorn
- mysql-connector-python

### Database
- MySQL

### AI / analytics direction
- Python
- Scikit-learn
- Feature engineering
- Predictive modeling
- Explainable AI
- API-based model serving

---

## Repository structure

```text
sports_analytics_demo-main/
│
├── Backend/
│   ├── app.py
│   ├── SportsDB_2.sql
│   ├── requirements.txt
│   └── startup.sh
│
└── Frontend/
    ├── package.json
    ├── package-lock.json
    ├── public/
    └── src/
        ├── App.js
        ├── Home.js
        ├── PlayerList.js
        ├── TeamList.js
        ├── MatchList.js
        ├── PlayerAwardList.js
        ├── PlayerDashboard.js
        ├── PlayerHistory.js
        ├── TeamHistory.js
        ├── MatchHistory.js
        ├── Login.js
        ├── ProtectedRoute.js
        ├── AuthContext.js
        └── ...
```

---

## Sample backend endpoints

### Health
```http
GET /api/health
```

### Players
```http
GET /api/players
GET /api/players/:player_id
```

### Teams
```http
GET /api/teams
GET /api/teams/:team_id
```

### Matches
```http
GET /api/matches
GET /api/matches/:match_id
```

Additional endpoints support users, player awards, and other detailed views in the application.

---

## What this project demonstrates about me

This project reflects my ability to work across the full stack and build systems that are ready for AI expansion.

### Full-stack engineering
- Building a responsive frontend in React
- Designing multi-page flows and protected navigation
- Developing backend APIs in Python/Flask
- Connecting application logic to a relational database
- Structuring reusable frontend/backend components

### Data and backend engineering
- Querying relational sports datasets with SQL
- Designing backend response structures for frontend consumption
- Handling date formatting and API serialization
- Preparing a system that can support future data pipelines and analytics workflows

### AI integration readiness
- Identifying where predictive models fit into product architecture
- Designing a system that can expose model outputs through APIs
- Planning explainability, forecasting, and intelligence features at the application layer

---

## Getting started

## 1. Clone the repository
```bash
git clone <your-repo-url>
cd sports_analytics_demo-main
```

## 2. Set up the MySQL database
- Create a MySQL database
- Import the SQL file from:

```text
Backend/SportsDB_2.sql
```

- Update the database connection settings inside `Backend/app.py`

Example:
```python
db_config = {
    "host": "localhost",
    "user": "root",
    "password": "your_password",
    "database": "Sportsdb"
}
```

## 3. Run the backend
```bash
cd Backend
pip install -r requirements.txt
python app.py
```

If you use Gunicorn in deployment:
```bash
gunicorn app:app
```

## 4. Run the frontend
```bash
cd Frontend
npm install
npm start
```

The frontend expects the backend API at:
```text
http://localhost:3001
```

If needed, update the API base URL in:
```text
Frontend/src/api.js
```

---

## Suggested improvements

To make this project even stronger for production and hiring portfolios, the next upgrades would be:

- Add environment variables for database credentials
- Replace hardcoded API URLs with config-based environment management
- Add search on every entity page
- Add pagination and filtering
- Add model-serving endpoints for predictions
- Add charts for team and player trends
- Add Docker support for full-stack deployment
- Add CI/CD pipeline
- Deploy frontend and backend to the cloud
- Add monitoring and logging
- Introduce a feature store or training pipeline for AI models

---

## Ideal use cases

This platform can evolve into:
- a sports performance intelligence dashboard
- a team scouting assistant
- a match prediction platform
- a player comparison engine
- an AI-powered analyst assistant for sports data exploration

---

## Resume-ready project summary

**AI-Powered Sports Analytics Platform**  
Built a full-stack sports analytics application using **React, Flask, and MySQL** to manage and visualize players, teams, matches, and awards through API-driven dashboards and history views. Designed the architecture to support future **AI integration** including match outcome prediction, player performance forecasting, explainable insights, and real-time analytics.

---

## Author

**Yashas Chandra Bathini**  
MS in Data Science, University of North Texas  
Full-Stack Engineer with AI Integration | Data Engineer 

---

## Final note

This project highlights a profile that is highly relevant for roles such as:

- Full-Stack Engineer with AI Integration
- Software Engineer
- Data Engineer
- Applied AI Engineer
- AI Product Engineer

It demonstrates both the **product engineering mindset** needed to build complete systems and the **AI integration mindset** needed to evolve them into intelligent applications.
