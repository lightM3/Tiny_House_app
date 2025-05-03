using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TinyHouseBackEnd.UserPackage
{
    internal abstract class AbsUser
    {

        public string UserName { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public string Address { get; set; }
        public int UserRoleLevel { get; set; } // 0 = Admin, 1 = HomeOwner, 2 = Tenant

        public AbsUser(string userName, string password, string email, string phoneNumber, string address, int userRoleLevel)
        {
            UserName = userName;
            Password = password;
            Email = email;
            PhoneNumber = phoneNumber;
            Address = address;
            UserRoleLevel = userRoleLevel;
        }

        public bool Login()
        {
            // Here we would have the logic to check if the user is in the database
            Console.WriteLine("User logged in.");
            return true; // We use true for just now, but this should be replaced with actual login logic
        }

        public bool Register()
        {
            // Here we would have the logic to register the user in the database
            Console.WriteLine("User registered.");
            return true; // We use true for just now, but this should be replaced with actual registration logic
        }

        public bool UnRegister() // Like delete account but "deleteAcoount()" this method will be in admin class
        {
            // Here we would have the logic to unregister the user in the database
            Console.WriteLine("User unregistered.");
            return true; // We use true for just now, but this should be replaced with actual unregistration logic
        }

        public bool UpdateProfile(string newUserName, string newPassword, string newEmail, string newPhoneNumber, string newAddress)
        {
            // Here we would have the logic to update the user profile in the database
            this.UserName = newUserName;
            this.Password = newPassword;
            this.Email = newEmail;
            this.PhoneNumber = newPhoneNumber;
            this.Address = newAddress;
            Console.WriteLine("User profile updated.");
            return true; // We use true for just now, but this should be replaced with actual update logic
        }

        public bool ChangePassword(string newPassword)
        {
            // Here we would have the logic to change the user password in the database
            this.Password = newPassword;
            Console.WriteLine("User password changed.");
            return true; // We use true for just now, but this should be replaced with actual change password logic
        }
    }
}
