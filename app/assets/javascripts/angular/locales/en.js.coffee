@Guru.config ($translateProvider) ->

  $translateProvider.translations "en",
    ERROR: "Sorry, an error occurred."
    LANGUAGE: "Language"
    ADD: "Add"
    USER:
      FIRST_NAME: "First Name"
      LAST_NAME: "Last Name"
      NAME: "Name"
      EMAIL: "Email"
      PASSWORD: "Password"
      PASSWORD_CONFIRMATION: "Password Confirmation"
      ADD_AN_EMPLOYEE: "Add an employee"
      ADD_A_CUSTOMER: "Add a customer"
      ROLE: "Role"
      SELECT_A_ROLE: "Select A Role"
    APPOINTMENT:
      DATE: "Date"
      START_TIME: "Start Time"
      END_TIME: "End Time"
      DURATION: "Duration"
      MASSEUR: "Masseur"
      CUSTOMER: "Customer"
      ADD_AN_APPOINTMENT: "Add an appointment"
      MASSEUR_CONFLICT: "This masseur already has an appointment in this time period."
      CUSTOMER_CONFLICT: "This customer already has an appointment in this time period."
    COMPANY:
      NAME_OF_YOUR_COMPANY: "Your Company's Name"
    SESSION:
      SIGNIN: "Sign in"
      SIGNUP: "Sign up"
      SIGNOUT: "Sign out"
      SIGNUP_SUCCESS: "You have successfully registered for an account! Please go to your email account to confirm."
      SIGNIN_SUCCESS: "You have signed in."
      SIGNOUT_SUCCESS: "You have signed out."
      EMAIL_CONFIRMED: "Your email has been confirmed."
      EMPLOYEE_ADDED: "You have successfully added an employee."
      CUSTOMER_ADDED: "You have successfully added a customer."
      INVALID_CREDENTIALS: "Your username/password combination is incorrect."
    DASHBOARD:
      MANAGE_YOUR_APPOINTMENTS: "Manage your appointments"
      MANAGE_YOUR_CUSTOMERS: "Manage your customers"
      MANAGE_YOUR_EMPLOYEES: "Manage your employees"
