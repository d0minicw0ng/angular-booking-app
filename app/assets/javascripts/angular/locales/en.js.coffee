@Guru.config ($translateProvider) ->

  $translateProvider.translations "en",
    LANGUAGE: "Language"
    USER:
      NAME: "Name"
      EMAIL: "Email"
      PASSWORD: "Password"
      PASSWORD_CONFIRMATION: "Password Confirmation"
    SESSION:
      SIGNIN: "Sign in"
      SIGNUP: "Sign up"
      SIGNOUT: "Sign out"
      SIGNUP_SUCCESS: "You have successfully registered for an account! Please go to your email account to confirm."
      SIGNIN_SUCCESS: "You have signed in."
      SIGNOUT_SUCCESS: "You have signed out."
      EMAIL_CONFIRMED: "Your email has been confirmed."
    DASHBOARD:
      MANAGE_YOUR_APPOINTMENTS: "Manage your appointments"
      MANAGE_YOUR_CUSTOMERS: "Manage your customers"
      MANAGE_YOUR_EMPLOYEES: "Manage your employees"