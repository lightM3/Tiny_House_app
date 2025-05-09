using System;
using System.Collections.Generic;
using Microsoft.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using System.Diagnostics;
using System.ComponentModel.Design;

namespace TinyHouseBackEnd.UserPackage
{
    internal class HomeOwner : AbsUser
    {

        private List<House> myHouses = new List<House>();

        private static readonly string connectionString = "Server=BERATZ\\SQLEXPRESS;Database=TinyHouseDb;Integrated Security=True;Encrypt=False";


        public HomeOwner() { } // Default constructor
        public HomeOwner(string userName, string password, string email, string phoneNumber, string address, int userRoleLevel)
            : base(userName, password, email, phoneNumber, address, userRoleLevel)
        {
        }

        public bool AddHouse(int price, string location, string description, double houseAvgStar, bool isAvaiable)
        {

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "insert into tblHouse (UserId,Price,HouseLocation,HouseDescription,HouseAvgStar,IsAvailable) values(@userid,@price,@houseLocation,@description,@AvgStar,@isAvailable)";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@userid", this.UserId);
                command.Parameters.AddWithValue("@price", price);
                command.Parameters.AddWithValue("@houseLocation", location);
                command.Parameters.AddWithValue("@description", description);
                command.Parameters.AddWithValue("@AvgStar", houseAvgStar);
                command.Parameters.AddWithValue("@isAvailable", Convert.ToInt32(isAvaiable));
                connection.Open();
                int rowsAffected = command.ExecuteNonQuery();

                if (rowsAffected == 0)
                {
                    Console.WriteLine("House adding opration was failed.");
                    return false;
                }

                House newHouse = new House(this.UserId, 500, "İzmir Gaziemir, Turkey", "2+1 Ogrenciye gider", houseAvgStar: 3.2, isAvaiable: true);
                myHouses.Add(newHouse);

                Console.WriteLine("House succesfully added");
                return true;

            }

        }

        public bool UnAddHouse(int houseid)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "delete from tblHouse where HouseId = @houseid and UserId = @userid";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@userid", this.UserId);
                command.Parameters.AddWithValue("@houseid", houseid);
                connection.Open();
                int rowsAffected = command.ExecuteNonQuery();

                if (rowsAffected == 0)
                {
                    Console.WriteLine("House deleting opration was failed.");
                    return false;
                }

                Console.WriteLine("House succesfully deleted");
                return true;

            }
        }

        public bool MakePassiveHouse(int houseid)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "update tblHouse set IsAvailable = @falseParameter where HouseId = @houseid and UserId = @userid";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@falseParameter", 0);
                command.Parameters.AddWithValue("@houseid", houseid);
                command.Parameters.AddWithValue("@userid", this.UserId);

                connection.Open();
                int rowsAffected = command.ExecuteNonQuery();

                if (rowsAffected > 0)
                {
                    Console.WriteLine("House status setted 0 successfully.");
                    return true;
                }
                else
                {
                    Console.WriteLine("House status operation failed.");
                    return false;
                }
            }
        }

        public bool MakeActiveHouse(int houseid)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "update tblHouse set IsAvailable = @trueParameter where HouseId = @houseid and UserId = @userid";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@trueParameter", 1);
                command.Parameters.AddWithValue("@houseid", houseid);
                command.Parameters.AddWithValue("@userid", this.UserId);

                connection.Open();
                int rowsAffected = command.ExecuteNonQuery();

                if (rowsAffected > 0)
                {
                    Console.WriteLine("House status setted 1 successfully.");
                    return true;
                }
                else
                {
                    Console.WriteLine("House status operation failed.");
                    return false;
                }
            }
        }

        public void ListMyHouse()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "select * from tblHouse where UserId = @userid";
                SqlCommand sqlCommand = new SqlCommand(query, connection);
                sqlCommand.Parameters.AddWithValue("@userid", this.UserId);
                connection.Open();

                SqlDataReader reader = sqlCommand.ExecuteReader();
                while (reader.Read())
                {
                    string houseId = reader["HouseId"].ToString();
                    int price = Convert.ToInt32(reader["Price"]);
                    string location = reader["HouseLocation"].ToString();
                    string description = reader["HouseDescription"].ToString();
                    double avgStar = Convert.ToDouble(reader["HouseAvgStar"]);
                    bool isAvailable = Convert.ToBoolean(reader["IsAvailable"]);

                    Console.WriteLine("-----------------------------------------");

                    Console.WriteLine($"HomeOwner Id: {this.UserId} \n" +
                    $"House Id.: {houseId} \n" +
                    $"House Price: {price} \n" +
                    $"House Location: {location} \n" +
                    $"House Description: {description} \n" +
                    $"House Avarage Star: {avgStar} \n" +
                    $"House Is Available: {(isAvailable ? true : false)} ");

                    Console.WriteLine("-----------------------------------------");
                }

            }
        }

        public void ListHouseCommands(int houseid)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string ownerCheckQuery = "select UserId from tblHouse where HouseId = @houseid";
                SqlCommand ownerCheckCommand = new SqlCommand(ownerCheckQuery, connection);
                ownerCheckCommand.Parameters.AddWithValue("@houseid", houseid);
                connection.Open();
                int ownerId = (int)ownerCheckCommand.ExecuteScalar();

                if (ownerId != this.UserId)
                {
                    Console.WriteLine("Access denied! You are not the owner of this house.");
                    return;
                }

                string query = "select * from tblComment where HouseId = @houseid";
                SqlCommand sqlCommand = new SqlCommand(query, connection);
                sqlCommand.Parameters.AddWithValue("@houseid", houseid);

                SqlDataReader reader = sqlCommand.ExecuteReader();
                while (reader.Read())
                {
                    string commentid = reader["CommentId"].ToString();
                    int userid = Convert.ToInt32(reader["UserId"]);
                    string content = reader["Content"].ToString();
                    double star = Convert.ToDouble(reader["Star"]);

                    Console.WriteLine("-----------------------------------------");

                    Console.WriteLine($"HomeOwner Id: {this.UserId} \n" +
                    $"Comment Id.: {commentid} \n" +
                    $"Commenter's Id: {userid} \n" +
                    $"Comment Content:  {content} \n" +
                    $"Comment Star:  {star} \n");

                    Console.WriteLine("-----------------------------------------");
                }

            }

        }

        public void UpdateHousePrice(int houseid, int newPrice)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "update tblHouse set Price = @newPrice where HouseId = @houseid and UserId = @userid";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@newPrice", newPrice);
                command.Parameters.AddWithValue("@houseid", houseid);
                command.Parameters.AddWithValue("@userid", this.UserId);

                connection.Open();
                int rowsAffected = command.ExecuteNonQuery();

                if (rowsAffected > 0)
                {
                    Console.WriteLine($"Price updated successfully. New Price: {newPrice}, HouseId: {houseid}");
                }
                else
                {
                    Console.WriteLine("Price update operation failed.");
                }
            }

        }

        //list waiting reservation requests

        public void ListWaitingReservation()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"select * from tblReservation where HouseId IN ( select HouseId from tblHouse where UserId = @userId) and ReservationStatus = 'Pending'";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@userId", this.UserId);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (!reader.HasRows)
                {
                    Console.WriteLine("No pending reservations found.");
                    return;
                }

                while (reader.Read())
                {
                    Console.WriteLine($"Reservation ID: {reader["ReservationId"]}, House ID: {reader["HouseId"]}, Tenant ID: {reader["TenantId"]}, Status: {reader["ReservationStatus"]}");
                }
            }
        }


        public void ConfirmReservation(int reservationId)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                //using join to check if the reservation belongs to the owner (DAHA BLMİYORUM YARDIM ALDIM)
                string ownerCheckQuery = @"
            SELECT h.UserId 
            FROM tblReservation r
            JOIN tblHouse h ON r.HouseId = h.HouseId
            WHERE r.ReservationId = @reservationId";

                SqlCommand ownerCheckCommand = new SqlCommand(ownerCheckQuery, connection);
                ownerCheckCommand.Parameters.AddWithValue("@reservationId", reservationId);

                connection.Open();
                object result = ownerCheckCommand.ExecuteScalar();

                if (result == null)
                {
                    Console.WriteLine("Reservation not found.");
                    return;
                }
                
                if (result.ToString() == "Confirmed")
                {
                    Console.WriteLine("Reservation already confirmed.");
                    return;
                }

                int ownerId = Convert.ToInt32(result);
                if (ownerId != this.UserId)
                {
                    Console.WriteLine("Access denied! You are not the owner of this reservation.");
                    return;
                }

                // Confirm the reservation
                string query = "update tblReservation set ReservationStatus = 'Confirmed' where ReservationId = @reservationId";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@reservationId", reservationId);

                int rowsAffected = command.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    Console.WriteLine($"Reservation {reservationId} confirmed successfully.");
                }
                else
                {
                    Console.WriteLine("Failed to confirm reservation.");
                }
            }
        }

        public void RejectReservation(int reservationId)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Checkin for house owning
                string ownerCheckQuery = @"
            SELECT h.UserId 
            FROM tblReservation r
            JOIN tblHouse h ON r.HouseId = h.HouseId
            WHERE r.ReservationId = @reservationId";

                SqlCommand ownerCheckCommand = new SqlCommand(ownerCheckQuery, connection);
                ownerCheckCommand.Parameters.AddWithValue("@reservationId", reservationId);

                connection.Open();
                object result = ownerCheckCommand.ExecuteScalar();

                if (result == null)
                {
                    Console.WriteLine("Reservation not found.");
                    return;
                }

                int ownerId = Convert.ToInt32(result);
                if (ownerId != this.UserId)
                {
                    Console.WriteLine("Access denied! You are not the owner of this reservation.");
                    return;
                }

                // reject the reservation
                string query = "update tblReservation set ReservationStatus = 'Rejected' where ReservationId = @reservationId";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@reservationId", reservationId);

                int rowsAffected = command.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    Console.WriteLine("Reservation rejected successfully.");
                }
                else
                {
                    Console.WriteLine("Failed to reject reservation.");
                }
            }
        }

        public void ListAllReservationForHouse(int houseid) 
        {
        
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                //check if owner has the house
                string ownerCheckQuery = "select UserId from  tblHouse where HouseId = @houseid";
                SqlCommand ownerCheckCommand = new SqlCommand(ownerCheckQuery, connection);
                ownerCheckCommand.Parameters.AddWithValue("@houseid", houseid);
                connection.Open();
                int ownerId = (int)ownerCheckCommand.ExecuteScalar();
                if (ownerId != this.UserId)
                {
                    Console.WriteLine("Access denied! You are not the owner of this house.");
                    return;
                }

                string query = "select * from tblReservation where HouseId = @houseid";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@houseid", houseid);
                SqlDataReader reader = command.ExecuteReader();
                if (!reader.HasRows)
                {
                    Console.WriteLine("No reservations found for this house.");
                    return;
                }
                while (reader.Read())
                {
                    Console.WriteLine($"House ID: {houseid}, Reservation ID: {reader["ReservationId"]}, Tenant ID: {reader["TenantId"]}, Status: {reader["ReservationStatus"]}");
                }
            }

        }

    }
}