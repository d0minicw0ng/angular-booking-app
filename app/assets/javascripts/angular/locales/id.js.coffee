@Guru.config ($translateProvider) ->

  $translateProvider.translations "id",
    LANGUAGE: "Bahasa"
    USER:
      NAME: "Nama"
      EMAIL: "Email"
      PASSWORD: "Password"
      PASSWORD_CONFIRMATION: "Password Konfirmasi"
    SESSION:
      SIGNIN: "Masuk"
      SIGNUP: "Daftar"
      SIGNOUT: "Keluar"
      SIGNUP_SUCCESS: "Anda telah berhasil terdaftar untuk account! Silakan pergi ke account email Anda untuk konfirmasi."
      EMAIL_CONFIRMED: "email Anda telah dikonfirmasi."
    DASHBOARD:
      MANAGE_YOUR_APPOINTMENTS: "Mengelola janji Anda"
      MANAGE_YOUR_CUSTOMERS: "Mengelola pelanggan Anda"
      MANAGE_YOUR_EMPLOYEES: "Mengelola karyawan Anda"
