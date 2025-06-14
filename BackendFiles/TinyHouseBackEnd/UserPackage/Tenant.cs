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
                string checkQuery = "SELECT dbo.fn_IsHouseAvailable(@houseId)";
                SqlCommand checkCommand = new SqlCommand(checkQuery, connection);
                checkCommand.Parameters.AddWithValue("@houseId", houseId);

                connection.Open();
                bool isAvailable = Convert.ToBoolean(checkCommand.ExecuteScalar());

                if (!isAvailable)
                {
                    Console.WriteLine("House is not available for rent.");
                    return;
                }

                string query = "UPDATE tblHouse SET IsAvailable = 0, WhoRent = @userid WHERE HouseId = @houseId";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@houseId", houseId);
                command.Parameters.AddWithValue("@userid", this.UserId);

                int rowsAffected = command.ExecuteNonQuery();

                if (rowsAffected > 0)
                {
                    Console.WriteLine("House rented successfully.");
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

        public void MakeReservations(int houseid, DateTime startDate, DateTime endDate)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                
                string checkHouseQuery = "SELECT dbo.fn_IsHouseAvailable(@houseId)";
                SqlCommand checkHouseCmd = new SqlCommand(checkHouseQuery, connection);
                checkHouseCmd.Parameters.AddWithValue("@houseId", houseid);
                bool isHouseAvailable = Convert.ToBoolean(checkHouseCmd.ExecuteScalar());

                if (!isHouseAvailable)
                {
                    Console.WriteLine("House is not available for reservation.");
                    return;
                }

                string checkDateQuery = "SELECT dbo.fn_IsReservationDateAvailable(@houseId, @startDate, @endDate)";
                SqlCommand checkDateCmd = new SqlCommand(checkDateQuery, connection);
                checkDateCmd.Parameters.AddWithValue("@houseId", houseid);
                checkDateCmd.Parameters.AddWithValue("@startDate", startDate);
                checkDateCmd.Parameters.AddWithValue("@endDate", endDate);
                bool isDateAvailable = Convert.ToBoolean(checkDateCmd.ExecuteScalar());

                if (!isDateAvailable)
                {
                    Console.WriteLine("House is not available for the selected dates.");
                    return;
                }

                string updateHouseQuery = "UPDATE tblHouse SET IsAvailable = 0, WhoRent = @whorent WHERE HouseId = @houseId";
                SqlCommand updateHouseCommand = new SqlCommand(updateHouseQuery, connection);
                updateHouseCommand.Parameters.AddWithValue("@houseId", houseid);
                updateHouseCommand.Parameters.AddWithValue("@whorent", this.UserId);
                updateHouseCommand.ExecuteNonQuery();

                string insertQuery = "INSERT INTO tblReservation (HouseId, TenantId, StartDate, EndDate, ReservationStatus, CreatedAt) " +
                                     "VALUES (@houseId, @userId, @startDate, @endDate, @status, @createdAt)";
                SqlCommand insertCommand = new SqlCommand(insertQuery, connection);
                insertCommand.Parameters.AddWithValue("@houseId", houseid);
                insertCommand.Parameters.AddWithValue("@userId", this.UserId);
                insertCommand.Parameters.AddWithValue("@startDate", startDate);
                insertCommand.Parameters.AddWithValue("@endDate", endDate);
                insertCommand.Parameters.AddWithValue("@status", "Pending");
                insertCommand.Parameters.AddWithValue("@createdAt", DateTime.Now);

                int rowsAffected = insertCommand.ExecuteNonQuery();

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


        // Payment Operations

        public void MakePayment(int reservationId, decimal paidAmount, string paymentMethod)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                //get House Price (BİLMİYORUM YARDIM ALDIM)
                string PriceQuery = @" SELECT h.Price FROM tblReservation r JOIN tblHouse h ON r.HouseId = h.HouseId WHERE r.ReservationId = @reservationId";

                SqlCommand Command = new SqlCommand(PriceQuery, connection);
                Command.Parameters.AddWithValue("@reservationId", reservationId);
                object result = Command.ExecuteScalar();

                if (result == null)
                {
                    Console.WriteLine("Reservation or related house not found.");
                    return;
                }

                decimal housePrice = Convert.ToDecimal(result);

                // check if the payment amount is equal to the house price
                string paymentStatus = paidAmount == housePrice ? "Successful" : "Failed";

                
                string insertQuery = @" INSERT INTO tblPayment (ReservationId, Amount, PaymentDate, PaymentStatus, PaymentMethod) VALUES (@reservationId, @amount, GETDATE(), @status, @method)";

                SqlCommand insertCommand = new SqlCommand(insertQuery, connection);
                insertCommand.Parameters.AddWithValue("@reservationId", reservationId);
                insertCommand.Parameters.AddWithValue("@amount", paidAmount);
                insertCommand.Parameters.AddWithValue("@status", paymentStatus);
                insertCommand.Parameters.AddWithValue("@method", paymentMethod);

                int rowsAffected = insertCommand.ExecuteNonQuery();

                if (rowsAffected > 0)
                {
                    Console.WriteLine($"Payment {paymentStatus} for Reservation {reservationId}.");
                }
                else
                {
                    Console.WriteLine("Payment failed to insert.");
                }
            }
        }


    }
}
