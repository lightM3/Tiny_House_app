using System;
using System.Collections.Generic;
using Microsoft.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using System.Diagnostics;

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

        public bool addHouse(int price, string location, string description, double houseAvgStar, bool isAvaiable)
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

        public bool unAddHouse(int houseid)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM tblHouse WHERE HouseId = @houseid and UserId = @userid";
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

        public bool makePassiveHouse(int houseid)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "UPDATE tblHouse SET IsAvailable = @falseParameter WHERE HouseId = @houseid and UserId = @userid";
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

        public bool makeActiveHouse(int houseid)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "UPDATE tblHouse SET IsAvailable = @trueParameter WHERE HouseId = @houseid and UserId = @userid";
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

        public void listMyHouse()
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
                    int price =Convert.ToInt32(reader["Price"]);
                    string location = reader["HouseLocation"].ToString();
                    string description = reader["HouseDescription"].ToString();
                    double avgStar = Convert.ToDouble(reader["HouseAvgStar"]);
                    bool isAvailable = Convert.ToBoolean(reader["IsAvailable"]);
                    
                    Console.WriteLine("-----------------------------------------");

                    Console.WriteLine($"User Id: {this.UserId} \n" +
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
            
        public void listHouseCommands(int houseid)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "select * from tblComment where HouseId = @houseid";
                SqlCommand sqlCommand = new SqlCommand(query, connection);
                sqlCommand.Parameters.AddWithValue("@houseid", houseid);
                connection.Open();

                SqlDataReader reader = sqlCommand.ExecuteReader();
                while (reader.Read())
                {
                    string commentid = reader["CommentId"].ToString();
                    int userid = Convert.ToInt32(reader["UserId"]);
                    string content = reader["Content"].ToString();
                    double star = Convert.ToDouble(reader["Star"]);
                    
                    Console.WriteLine("-----------------------------------------");

                    Console.WriteLine($"User Id: {this.UserId} \n" +
                    $"Comment Id.: {commentid} \n" +
                    $"Commenter's Id: {userid} \n" +
                    $"Comment Content:  {content} \n" +
                    $"Comment Star:  {star} \n" );

                    Console.WriteLine("-----------------------------------------");
                }

            }

        }

        public void updateHousePrice(int houseid,int newPrice) 
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "UPDATE tblHouse SET Price = @newPrice WHERE HouseId = @houseid and UserId = @userid";
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

    }
}
