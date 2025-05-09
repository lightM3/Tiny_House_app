using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;

namespace TinyHouseBackEnd.UserPackage
{
    internal class Tenant : AbsUser
    {


        private static readonly string connectionString = "Server=BERATZ\\SQLEXPRESS;Database=TinyHouseDb;Integrated Security=True;Encrypt=False";

        public Tenant() { } // Default constructor
        public Tenant(string userName, string password, string email, string phoneNumber, string address, int userRoleLevel)
            : base(userName, password, email, phoneNumber, address, userRoleLevel)
        {
        }

        public void ListAvailableHouses()
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "select * from tblHouse where IsAvailable = 1";
                    SqlCommand sqlCommand = new SqlCommand(query, connection);
                    connection.Open();

                    SqlDataReader reader = sqlCommand.ExecuteReader();

                    if (!reader.HasRows)
                    {
                        Console.WriteLine("No available houses found.");
                        return;
                    }

                    while (reader.Read())
                    {
                        string houseId = reader["HouseId"].ToString();
                        int price = Convert.ToInt32(reader["Price"]);
                        string location = reader["HouseLocation"].ToString();
                        string description = reader["HouseDescription"].ToString();
                        double avgStar = Convert.ToDouble(reader["HouseAvgStar"]);
                        bool isAvailable = Convert.ToBoolean(reader["IsAvailable"]);

                        Console.WriteLine("-----------------------------------------");
                        Console.WriteLine($"" +
                            $"House Id.: {houseId} \n" +
                            $"House Price: {price} \n" +
                            $"House Location: {location} \n" +
                            $"House Description: {description} \n" +
                            $"House Average Star: {avgStar} \n" +
                            $"House Is Available: {isAvailable}");
                        Console.WriteLine("-----------------------------------------");
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }
        }

        public void RentHouse(int houseId)
        {

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                //Check before renting for is available = 1 ?
                string checkQuery = "select COUNT(*) from tblHouse where HouseId = @houseId and IsAvailable = 1";
                SqlCommand checkCommand = new SqlCommand(checkQuery, connection);
                checkCommand.Parameters.AddWithValue("@houseId", houseId);
                connection.Open();
                int count = (int)checkCommand.ExecuteScalar();
                if (count == 0)
                {
                    Console.WriteLine("House is not available for rent.");
                    return;
                }

                string query = "update tblHouse set IsAvailable = 0,WhoRent = @userid where HouseId = @houseId";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@houseId", houseId);
                command.Parameters.AddWithValue("@userid", this.UserId);
                int rowsAffected = command.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    Console.WriteLine("House rented successfully.");
                    return;
                }
            }

        }

        public void UnRentHouse(int houseId)
        {

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "update tblHouse set IsAvailable = 1, WhoRent = NULL where HouseId = @houseId and WhoRent = @userid";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@houseId", houseId);
                command.Parameters.AddWithValue("@userid", this.UserId);
                connection.Open();
                int rowsAffected = command.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    Console.WriteLine("House status setted Null successfully.");
                    return;
                }
                else
                {
                    Console.WriteLine("House UnRent operation failed.");
                    return;
                }
            }


        }

        public void AddComment(int houseId, string content, int star)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO tblComment (HouseId, UserId, Content, Star) select @houseId, @userId, @content, @starwhere EXISTS (select 1 from tblHousewhere HouseId = @houseId and WhoRent = @userId)";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@houseId", houseId);
                command.Parameters.AddWithValue("@userId", this.UserId);
                command.Parameters.AddWithValue("@content", content);
                command.Parameters.AddWithValue("@star", star);

                connection.Open();
                int rowsAffected = command.ExecuteNonQuery();

                if (rowsAffected > 0)
                {
                    Console.WriteLine("Comment added successfully");
                    return;
                }
                else
                {
                    Console.WriteLine("Comment not added");
                    return;
                }
            }
        }

        //Reservation Operations

        public void MakeReservations(int houseid,DateTime startDate, DateTime endDate)
        {

            using (SqlConnection connection = new SqlConnection(connectionString)) 
            {
                //Check if the house is available
                string checkQuery = "select COUNT(*) from tblHouse where HouseId = @houseId and IsAvailable = 1";
                SqlCommand checkCommand = new SqlCommand(checkQuery, connection);
                checkCommand.Parameters.AddWithValue("@houseId", houseid);
                connection.Open();
                int count = (int)checkCommand.ExecuteScalar();
                if (count == 0)
                {
                    Console.WriteLine("House is not available for reservation.");
                    return;
                }
                //Check if the reservation dates are valid
                string checkDateQuery = "select COUNT(*) from tblReservation where HouseId = @houseId and ((StartDate <= @endDate and EndDate >= @startDate) or (StartDate >= @startDate and StartDate <= @endDate))";
                SqlCommand checkDateCommand = new SqlCommand(checkDateQuery, connection);
                checkDateCommand.Parameters.AddWithValue("@houseId", houseid);
                checkDateCommand.Parameters.AddWithValue("@startDate", startDate);
                checkDateCommand.Parameters.AddWithValue("@endDate", endDate);
                int dateCount = (int)checkDateCommand.ExecuteScalar();
                if (dateCount > 0)
                {
                    Console.WriteLine("House is not available for the selected dates.");
                    return;
                }

                //Set the house as unavailable from tblHouse
                string updateHouseQuery = "update tblHouse set IsAvailable = 0,WhoRent = @whorent where HouseId = @houseId";
                SqlCommand updateHouseCommand = new SqlCommand(updateHouseQuery, connection);
                updateHouseCommand.Parameters.AddWithValue("@houseId", houseid);
                updateHouseCommand.Parameters.AddWithValue("@whorent", this.UserId);
                updateHouseCommand.ExecuteNonQuery();

                //Insert the reservation into the database

                string query = "INSERT INTO tblReservation (HouseId, TenantId, StartDate, EndDate, ReservationStatus, CreatedAt) VALUES (@houseId, @userId, @startDate, @endDate, @status, @createdAt)";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@houseId", houseid);
                command.Parameters.AddWithValue("@userId", this.UserId);
                command.Parameters.AddWithValue("@startDate", startDate);
                command.Parameters.AddWithValue("@endDate", endDate);
                command.Parameters.AddWithValue("@status", "Pending");
                command.Parameters.AddWithValue("@createdAt", DateTime.Now); 

                
                int rowsAffected = command.ExecuteNonQuery();

                if (rowsAffected > 0)
                {
                    Console.WriteLine("Reservation made successfully.");
                }
                else
                {
                    Console.WriteLine("Reservation failed.");
                }
            }

        }

        public void ListMyReservations() 
        {
        
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "select * from tblReservation where TenantId = @userId";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@userId", this.UserId);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    int reservationId = Convert.ToInt32(reader["ReservationId"]);
                    int houseId = Convert.ToInt32(reader["HouseId"]);
                    DateTime startDate = Convert.ToDateTime(reader["StartDate"]);
                    DateTime endDate = Convert.ToDateTime(reader["EndDate"]);
                    string status = reader["ReservationStatus"].ToString();
                    DateTime createdAt = Convert.ToDateTime(reader["CreatedAt"]);
                    Console.WriteLine("-----------------------------------------");
                    Console.WriteLine($"" +
                    $"Reservation Id.: {reservationId} \n" +
                    $"House Id: {houseId} \n" +
                    $"Start Date: {startDate} \n" +
                    $"End Date: {endDate} \n" +
                    $"Status: {status} \n" +
                    $"Created At: {createdAt}");
                    Console.WriteLine("-----------------------------------------");
                }
            }

        }

        public void CancelMyReservation(int reservationId)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "update tblReservation set ReservationStatus = @status where ReservationId = @reservationId and TenantId = @userId";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@reservationId", reservationId);
                command.Parameters.AddWithValue("@userId", this.UserId);
                command.Parameters.AddWithValue("@status", "Cancelled");

                connection.Open();
                int rowsAffected = command.ExecuteNonQuery();

                if (rowsAffected > 0)
                {
                    Console.WriteLine("Reservation cancelled successfully.");
                }
                else
                {
                    Console.WriteLine("Cancellation failed. You may not be the owner of this reservation.");
                }
            }
        }

    }
}
