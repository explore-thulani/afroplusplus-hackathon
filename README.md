# MTN Business Hack - Afro++

## Project Setup
    - Mobile App (Afrecruit).
    - Robotic Automation Tool - Easy Apply.
    - Firebase or Custom API with Database for user details.
    - Simple Admin Dashboard to post jobs and select candidates.

## Application Flow

	App (Client) -> RPA (Cloud based tool) -> API -> Database -> Admin Dashboard

## 1. App (Client)
	* User authentication and Registration
	* Job posts (List => {Company, Job title, Job Description, Qualifications, Requirements, keywords})
	* User profile (List = {Name, Surname, Email, Avatar, Skills, Qualifications, keywords})

## 2. RPA (Cloud based Tool)
	* Gets user profile
	* Matches users with suitable job posts
	* Submits applications automatically when there's a match

## 3. API (Flask)
	* Receives user data from Client App to update database
	* Gets specific requests for job posts from RPA tool
	* Queries data base and sends them to RPA tool for matches
	* Stores user profiles that match job posts

## 4. Database
	* Stores [Job title, Job specs, Location, Number of Applicants]

## 5. Admin Dashboard
	* Access Database to post jobs and manage applicants.
