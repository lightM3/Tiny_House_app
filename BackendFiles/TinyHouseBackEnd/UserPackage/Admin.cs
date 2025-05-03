using System;

namespace TinyHouseBackEnd.UserPackage
{
    internal class Admin : AbsUser
    {

        public Admin(string userName, string password, string email, string phoneNumber, string address, int userRoleLevel)
            : base(userName, password, email, phoneNumber, address, userRoleLevel)
        {
            UserName = userName;
            Password = password;
            Email = email;
            PhoneNumber = phoneNumber;
            Address = address;
            UserRoleLevel = userRoleLevel;
        }
    }
}
