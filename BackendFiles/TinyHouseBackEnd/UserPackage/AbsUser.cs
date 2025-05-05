using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using Microsoft.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Identity.Client;
using System.Runtime.CompilerServices;

namespace TinyHouseBackEnd.UserPackage
{
    internal abstract class AbsUser
    {

        private int UserId { get; set; }
        private string UserName { get; set; }
        private string Password { get; set; }
        private string Email { get; set; }
        private string PhoneNumber { get; set; }
        private string Address { get; set; }
        public int UserRoleLevel { get; set; } // 0 = Admin, 1 = HomeOwner, 2 = Tenant

        private static readonly string connectionString = "Server=BERATZ\\SQLEXPRESS;Database=TinyHouseDb;Integrated Security=True;Encrypt=False";

        public AbsUser() { } // Default constructor
        public AbsUser(string userName, string password, string email, string phoneNumber, string address, int userRoleLevel)
        {
            UserName = userName;
            Password = password;
            Email = email;
            PhoneNumber = phoneNumber;
            Address = address;
            UserRoleLevel = userRoleLevel;
        }

        internal static class UserFactory
        {
            public static AbsUser Login(string username, string password)
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT * FROM tblUser WHERE UserName = @username AND Password = @password";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@username", username);
                    command.Parameters.AddWithValue("@password", password);

                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        int userRole = Convert.ToInt32(reader["UserRoleLevel"]);
                        string email = reader["Email"].ToString();
                        string phone = reader["PhoneNumber"].ToString();
                        string address = reader["Address"].ToString();
                        int userId = Convert.ToInt32(reader["UserId"]);

                        AbsUser user = userRole switch
                        {
                            0 => new Admin(username, password, email, phone, address, userRole),
                            1 => new HomeOwner(username, password, email, phone, address, userRole),
                            2 => new Tenant(username, password, email, phone, address, userRole),
                            _ => throw new Exception("Geçersiz kullanıcı rolü!")
                        };

                        user.UserId = userId;
                        return user;
                    }

                    return null;
                }
            }

            public static AbsUser Register(string username, string password, string email, string phoneNumber, string address, int userRoleLevel)
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string checkQuery = "SELECT COUNT(*) FROM tblUser WHERE UserName = @username";
                    SqlCommand checkCommand = new SqlCommand(checkQuery, connection);
                    checkCommand.Parameters.AddWithValue("@username", username);
                    connection.Open();
                    int userExists = (int)checkCommand.ExecuteScalar();

                    if (userExists > 0)
                    {
                        Console.WriteLine("Bu kullanıcı adı zaten alınmış.");
                        return null;
                    }

                    string query = "INSERT INTO tblUser (UserName, Password, Email, PhoneNumber, Address, UserRoleLevel) VALUES (@username, @password, @email, @phoneNumber, @address, @userRoleLevel)";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@username", username);
                    command.Parameters.AddWithValue("@password", password);
                    command.Parameters.AddWithValue("@email", email);
                    command.Parameters.AddWithValue("@phoneNumber", phoneNumber);
                    command.Parameters.AddWithValue("@address", address);
                    command.Parameters.AddWithValue("@userRoleLevel", userRoleLevel);

                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected == 0)
                    {
                        Console.WriteLine("Kayıt yapılamadı.");
                        return null;
                    }

                    AbsUser user = userRoleLevel switch
                    {
                        0 => new Admin(username, password, email, phoneNumber, address, userRoleLevel),
                        1 => new HomeOwner(username, password, email, phoneNumber, address, userRoleLevel),
                        2 => new Tenant(username, password, email, phoneNumber, address, userRoleLevel),
                        _ => throw new Exception("Geçersiz kullanıcı rolü!")
                    };
                    user.UserId = (int)new SqlCommand("SELECT max(UserId) from tblUser", connection).ExecuteScalar();
                    user.UserName = username;
                    user.Password = password;
                    user.Email = email;
                    user.PhoneNumber = phoneNumber;
                    user.Address = address;
                    user.UserRoleLevel = userRoleLevel;
                    return user;
                }
            }
            
        }

        public void UpdateProfile(string newUserName, string newPassword, string newEmail, string newPhoneNumber, string newAddress)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "UPDATE tblUser SET UserName = @newUserName, Password = @newPassword, Email = @newEmail, PhoneNumber = @newPhoneNumber, Address = @newAddress WHERE UserId = @userId";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@newUserName", newUserName);
                command.Parameters.AddWithValue("@newPassword", newPassword);
                command.Parameters.AddWithValue("@newEmail", newEmail);
                command.Parameters.AddWithValue("@newPhoneNumber", newPhoneNumber);
                command.Parameters.AddWithValue("@newAddress", newAddress);
                command.Parameters.AddWithValue("@userId", this.UserId);

                connection.Open();
                int rowsAffected = command.ExecuteNonQuery();

                if (rowsAffected > 0)
                {
                    Console.WriteLine("User profile updated successfully.");
                }
                else
                {
                    Console.WriteLine("User profile update failed.");
                }
            }
        }
        public void UnRegister()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM tblUser WHERE UserName = @username";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@username", this.UserName);

                connection.Open();
                int rowsAffected = command.ExecuteNonQuery();

                if (rowsAffected > 0)
                {
                    Console.WriteLine("Kullanıcı başarıyla silindi.");
                }
                else
                {
                    Console.WriteLine("Kullanıcı silinemedi. Kullanıcı adı bulunamadı.");
                }
            }
        }
        public void ChangePassword(string newPassword)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "UPDATE tblUser SET Password = @newPassword WHERE UserId = @userId";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@newPassword", newPassword);
                command.Parameters.AddWithValue("@userId", this.UserId);

                connection.Open();
                int rowsAffected = command.ExecuteNonQuery();

                if (rowsAffected > 0)
                {
                    Console.WriteLine("User password changed successfully.");
                }
                else
                {
                    Console.WriteLine("User password change failed.");
                }
            }
        }
    }
}
