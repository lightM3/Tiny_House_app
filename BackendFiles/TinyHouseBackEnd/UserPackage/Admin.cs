using System;
using Microsoft.Data.SqlClient;
using System.Net;

namespace TinyHouseBackEnd.UserPackage
{
    internal class Admin : AbsUser
    {

        public Admin() { } // Default constructor
        public Admin(string userName, string password, string email, string phoneNumber, string address, int userRoleLevel)
            : base(userName, password, email, phoneNumber, address, userRoleLevel)
        {
        }

        private static readonly string connectionString = "Server=BERATZ\\SQLEXPRESS;Database=TinyHouseDb;Integrated Security=True;Encrypt=False";


        //Admin Account Management
        public void AddNewAccount(string userName,string password, string email, string phoneNumber, string address,int userRoleLevel) 
        {
            using (SqlConnection connection = new SqlConnection(connectionString)) 
            {

                string checkQuery = "select COUNT(*) from tblUser WHERE UserName = @username";
                SqlCommand checkCommand = new SqlCommand(checkQuery, connection);
                checkCommand.Parameters.AddWithValue("@username", userName);
                connection.Open();
                int userExists = (int)checkCommand.ExecuteScalar();

                if (userExists > 0)
                {
                    Console.WriteLine("This userName allready exist.");
                    return;
                }

                string query = "INSERT INTO tblUser (UserName, Password, Email, PhoneNumber, Address, UserRoleLevel, IsAccountActive) VALUES (@username, @password, @email, @phoneNumber, @address, @userRoleLevel, 1)";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@username", userName);
                command.Parameters.AddWithValue("@password", password);
                command.Parameters.AddWithValue("@email", email);
                command.Parameters.AddWithValue("@phoneNumber", phoneNumber);
                command.Parameters.AddWithValue("@address", address);
                command.Parameters.AddWithValue("@userRoleLevel", userRoleLevel);

                int rowsAffected = command.ExecuteNonQuery();

                if (rowsAffected == 0)
                {
                    Console.WriteLine("Addition operation was failed.");
                    return;
                }
                
                Console.WriteLine("New user was added successfully.");
            }
        }

        public void DeleteAccount(int userid)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "delete from tblUser where UserId = @userid";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@userid", userid);
                connection.Open();
                int rowsAffected = command.ExecuteNonQuery();
                if (rowsAffected == 0)
                {
                    Console.WriteLine("Deletion operation was failed.");
                    return;
                }
                Console.WriteLine("User was deleted successfully.");
            }
        }

        public void UpdateAccount(int userid,string newUserName, string newPassword, string newEmail, string newPhoneNumber, string newAddress) 
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "update tblUser set UserName = @newUserName, Password = @newPassword, Email = @newEmail, PhoneNumber = @newPhoneNumber, Address = @newAddress where UserId = @userid";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@userid", userid);
                command.Parameters.AddWithValue("@newUserName", newUserName);
                command.Parameters.AddWithValue("@newPassword", newPassword);
                command.Parameters.AddWithValue("@newEmail", newEmail);
                command.Parameters.AddWithValue("@newPhoneNumber", newPhoneNumber);
                command.Parameters.AddWithValue("@newAddress", newAddress);
                connection.Open();
                int rowsAffected = command.ExecuteNonQuery();
                if (rowsAffected == 0)
                {
                    Console.WriteLine("Update operation was failed.");
                    return;
                }
                Console.WriteLine($"User {userid} was updated successfully. By Admin Admin's id: {this.UserId}");

            }
        }

        public void MakeUserPassiveBetweenDates(int userid, DateTime startDate, DateTime endDate)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                if (this.UserRoleLevel != 0)
                {
                    Console.WriteLine("Access Denied. You are not Admin.");
                    return;
                }
                // check for user allreadt passive
                string checkQuery = "select COUNT(*) from tblUser where UserId = @userid and IsAccountActive = 0";
                SqlCommand checkCommand = new SqlCommand(checkQuery, connection);
                checkCommand.Parameters.AddWithValue("@userid", userid);
                connection.Open();
                int userExists = (int)checkCommand.ExecuteScalar();
                if (userExists > 0)
                {
                    Console.WriteLine("This user is already passive.");
                    return;
                }


                //set isaccount active to 0
                string checkQuery2 = "update tblUser set IsAccountActive = 0 where UserId = @userid";
                SqlCommand checkCommand2 = new SqlCommand(checkQuery2, connection);
                checkCommand2.Parameters.AddWithValue("@userid", userid);
                
                string query = " update tblUser set IsAccountActive = 0, UserPassiveStartDate = @startDate, UserPassiveEndDate = @endDate where UserId = @userid";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@userid", userid);
                command.Parameters.AddWithValue("@startDate", startDate);
                command.Parameters.AddWithValue("@endDate", endDate);

                int rowsAffected = command.ExecuteNonQuery();
                
                if (rowsAffected == 0)
                {
                    Console.WriteLine("Making account passive operation was failed.");
                    return;
                }
                else
                { 
                    Console.WriteLine($"User {userid} was made passive successfully.");
                    return;
                }
            }
        }


        public void MakeActiveAccount(int userid) 
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                if (this.UserRoleLevel != 0)
                {
                    Console.WriteLine("Access Denied. You are not Admin.");
                    return;
                }
                // check for user allreadt active
                string checkQuery = "select COUNT(*) from tblUser where UserId = @userid and IsAccountActive = 1";
                SqlCommand checkCommand = new SqlCommand(checkQuery, connection);
                checkCommand.Parameters.AddWithValue("@userid", userid);
                connection.Open();
                int userExists = (int)checkCommand.ExecuteScalar();
                if (userExists > 0)
                {
                    Console.WriteLine("This user is already active.");
                    return;
                }


                string query = "update tblUser set IsAccountActive = 1, UserPassiveStartDate = NULL, UserPassiveEndDate = NULL where UserId = @userid";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@userid", userid);
                int rowsAffected = command.ExecuteNonQuery();
                if (rowsAffected == 0)
                {
                    Console.WriteLine("Making account active operation was failed.");
                    return;
                }
                Console.WriteLine("User was made active successfully.");
            }
        }

        //Admin House Management
        public void DeleteHouse(int houseid)
        {
            using (SqlConnection connection = new SqlConnection(connectionString)) 
            {
                if (this.UserRoleLevel == 0)
                {

                    string query = "delete from tblHouse where HouseId = @houseid";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@houseid", houseid);
                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();
                    if (rowsAffected == 0)
                    {
                        Console.WriteLine("Deletion operation was failed.");
                        return;
                    }
                    Console.WriteLine("House was deleted successfully.");
                    // Delete this house's comments
                    string query2 = "delete from tblComment where HouseId = @houseid";
                    SqlCommand command2 = new SqlCommand(query2, connection);
                    command2.Parameters.AddWithValue("@houseid", houseid);
                    rowsAffected =  command2.ExecuteNonQuery();
                    if (rowsAffected == 0)
                    {
                        Console.WriteLine("Comment Deletion operation was failed.");
                        return;
                    }
                    Console.WriteLine("House's comments were deleted successfully.");
                }
                else 
                {
                    Console.WriteLine("Access Denied. You are not Admin.");
                }

            }


        }
        
        public void MakePassiveHouse(int houseid)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                if (this.UserRoleLevel == 0)
                {
                    connection.Open();
                    string query = "update tblHouse set IsAvailable = 0, WhoRent = NULL, IsHouseActive = 0 where HouseId = @houseid";

                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@houseid", houseid);
                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected == 0)
                    {
                        Console.WriteLine("Making house passive operation failed.");
                    }
                    else
                    {
                        Console.WriteLine("House was made passive successfully.");
                    }
                }
            }
        }
        
        public void MakeActiveHouse(int houseid)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                if (this.UserRoleLevel == 0)
                {
                    connection.Open();
                    string query = "update tblHouse set IsAvailable = 1, IsHouseActive = 1 where HouseId = @houseid"; 
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@houseid", houseid);
                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected == 0)
                    {
                        Console.WriteLine("Making house active operation failed.");
                    }
                    else
                    {
                        Console.WriteLine("House was made active successfully.");
                    }
                }
            }
        }


        //Admin reservation management

        public void ListAllResetvations()
        {

            using (SqlConnection connection = new SqlConnection(connectionString))
            {

                //Cheching if the user is admin
                if (this.UserRoleLevel != 0)
                {
                    Console.WriteLine("Access Denied. You are not Admin.");
                    return;
                }

                string query = "select * from tblReservation";
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Console.WriteLine($"ReservationId: {reader["ReservationId"]}, HouseId: {reader["HouseId"]}, TenantId: {reader["TenantId"]}, StartDate: {reader["StartDate"]}, EndDate: {reader["EndDate"]}, Reservation Status : {reader["ReservationStatus"]}");
                }
            }

        }

        public void RejectReservation(int reservationId)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                if (this.UserRoleLevel != 0)
                {
                    Console.WriteLine("Access Denied. You are not Admin.");
                    return;
                }

                string query = "update tblReservation set ReservationStatus = 0 where ReservationId = @reservationId";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@reservationId", reservationId);
                connection.Open();
                int rowsAffected = command.ExecuteNonQuery();
                if (rowsAffected == 0)
                {
                    Console.WriteLine("Rejection operation was failed.");
                    return;
                }
                Console.WriteLine("Reservation was rejected successfully.");
            }
        }


        // List Payments

        public void ListAllPayments()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                //Cheching if the user is admin
                if (this.UserRoleLevel != 0)
                {
                    Console.WriteLine("Access Denied. You are not Admin.");
                    return;
                }
                string query = "select * from tblPayment";
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Console.WriteLine($"PaymentId: {reader["PaymentId"]}, ReservationId: {reader["ReservationId"]}, Amount: {reader["Amount"]}, PaymentDate: {reader["PaymentDate"]}, PaymentStatus: {reader["PaymentStatus"]}, PaymentMethod: {reader["PaymentMethod"]}");
                }
            }
        }

        public void ListAllPaymentByUser(int userid)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                //Cheching if the user is admin
                if (this.UserRoleLevel != 0)
                {
                    Console.WriteLine("Access Denied. You are not Admin.");
                    return;
                }
                string query = "select * from tblPayment where UserId = @userid";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@userid", userid);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Console.WriteLine($"PaymentId: {reader["PaymentId"]}, ReservationId: {reader["ReservationId"]}, Amount: {reader["Amount"]}, PaymentDate: {reader["PaymentDate"]}, PaymentStatus: {reader["PaymentStatus"]}, PaymentMethod: {reader["PaymentMethod"]}");
                }
            }
        }

        public void ListAllPaymentsByHouse(int houseid)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                //Cheching if the user is admin
                if (this.UserRoleLevel != 0)
                {
                    Console.WriteLine("Access Denied. You are not Admin.");
                    return;
                }
                string query = "select * from tblPayment where HouseId = @houseid";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@houseid", houseid);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    Console.WriteLine($"PaymentId: {reader["PaymentId"]}, ReservationId: {reader["ReservationId"]}, Amount: {reader["Amount"]}, PaymentDate: {reader["PaymentDate"]}, PaymentStatus: {reader["PaymentStatus"]}, PaymentMethod: {reader["PaymentMethod"]}");
                }
            }
        }


    }

}
