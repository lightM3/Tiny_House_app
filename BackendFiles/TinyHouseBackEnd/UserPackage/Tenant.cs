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

        public void listAvailableHouses()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "select * from tblHouse where IsAvailable = 1";
                SqlCommand sqlCommand = new SqlCommand(query, connection);
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

                    Console.WriteLine($"" +
                    $"House Id.: {houseId} \n" +
                    $"House Price: {price} \n" +
                    $"House Location: {location} \n" +
                    $"House Description: {description} \n" +
                    $"House Avarage Star: {avgStar} \n" +
                    $"House Is Available: {(isAvailable ? true : false)} ");

                    Console.WriteLine("-----------------------------------------");
                }
                if (reader.HasRows == false)
                {
                    Console.WriteLine("No available houses found.");
                }

            }


        }

        public void RentHouse(int houseId)
        {

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                //Check before renting for is available = 1 ?
                string checkQuery = "SELECT COUNT(*) FROM tblHouse WHERE HouseId = @houseId AND IsAvailable = 1";
                SqlCommand checkCommand = new SqlCommand(checkQuery, connection);
                checkCommand.Parameters.AddWithValue("@houseId", houseId);
                connection.Open();
                int count = (int)checkCommand.ExecuteScalar();
                if (count == 0)
                {
                    Console.WriteLine("House is not available for rent.");
                    return;
                }

                string query = "UPDATE tblHouse SET IsAvailable = 0,WhoRent = @userid WHERE HouseId = @houseId";
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
                string query = "UPDATE tblHouse SET IsAvailable = 1, WhoRent = NULL WHERE HouseId = @houseId and WhoRent = @userid";
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
                string query = @"
            INSERT INTO tblComment (HouseId, UserId, Content, Star)
            select @houseId, @userId, @content, @star
            where EXISTS (
                select 1 from tblHouse
                where HouseId = @houseId and WhoRent = @userId
            )";

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


    }
}
