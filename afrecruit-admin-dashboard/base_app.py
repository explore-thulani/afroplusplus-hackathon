import streamlit as st
import time
from PIL import Image

dashero = Image.open('resources/imgs/undraw_dashboard_nklg.png')
analytics = Image.open('resources/imgs/undraw_progress_data_4ebj.png')

def login(email, password):
    with st.spinner('Wait for it...'):
        time.sleep(5)

    if len(email) == 0 or len(password) == 0:
        st.error('Invalid Email or Password')
        return False
    else:
        st.success('Logged in successfully!')
        return True

def dashboard():
    options = ["Post a Job","Select Candidates","Analytics"]
    chosen = st.selectbox('What to do?', options)
    job_title = ""
    job_description = ""
    keywords = []
    experience = ""
    qualifications = ""

    if chosen == "Post a Job":
        st.subheader('Post a Job')
        job_title = st.text_input('Job title:')
        job_description = st.text_area('Job description')
        keywords = st.multiselect('Keywords:', ['Technology', 'Agriculture','Health','Education'])
        experience = st.number_input('Years of Experience', value = 0,min_value=0, max_value=5)
        qualifications = st.text_area('Qualifications')
        if st.button('Post Job'):
            job_title = ""
            job_description = ""
            keywords = []
            experience = ""
            qualifications = ""
            st.success('Posted Successfully')

    if chosen == "Select Candidates":
        st.subheader('Select Candidate for Job')
        job = st.selectbox('Jobs:', ['Artists','Engineers','Doctors','Drivers'])
        if job == "Engineers":
            candidates = st.multiselect('Shortlisted',['Thami','Thulani','Sabelo','Tumi','Dineo'])
            if st.button('Confirm'):
                st.success('Candidates have been notified')
        if job == "Artists":
            candidates = st.multiselect('Shortlisted',['Thami','Thulani','Sabelo','Tumi','Dineo'])
            if st.button('Confirm'):
                st.success('Candidates have been notified') 
        if job == "Doctors":
            candidates = st.multiselect('Shortlisted',['Thami','Thulani','Sabelo','Tumi','Dineo'])
            if st.button('Confirm'):
                st.success('Candidates have been notified')
        if job == "Drivers":
            candidates = st.multiselect('Shortlisted',['Thami','Thulani','Sabelo','Tumi','Dineo'])
            if st.button('Confirm'):
                st.success('Candidates have been notified')

    if chosen == "Analytics":
        st.subheader('Data Analytics')
        st.image(analytics, caption='Job posts analytics', use_column_width=True)




def main():
    """Admin dashboard for Afrecruit"""

    st.title("Afrecruit Dashboard")
    st.image(dashero, caption='Enriching the Youth of South Africa', use_column_width=True)

    option = st.sidebar.selectbox('Menu',["Login","Dashboard","Logout"])

    if option == "Login":
        st.header('Login to admin')
        email = st.text_input(label='Email/Username', value='')
        password = st.text_input(label='Password', value='')
        if st.button('Login'):
            if login(email, password):
                option = "Dashboard"
    
    if option == "Dashboard":
        st.header('Welcome to admin dashboard')
        dashboard()

    if option == "Logout":
        st.header('Login to admin')
        email = st.text_input(label='Email/Username', value='')
        password = st.text_input(label='Password', value='')
        if st.button('Login'):
            if login(email, password):
                index = 1



if __name__ == '__main__':
    main()
