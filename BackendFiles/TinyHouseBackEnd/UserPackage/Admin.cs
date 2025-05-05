using System;

namespace TinyHouseBackEnd.UserPackage
{
    internal class Admin : AbsUser
    {

        public Admin() { } // Default constructor
        public Admin(string userName, string password, string email, string phoneNumber, string address, int userRoleLevel)
            : base(userName, password, email, phoneNumber, address, userRoleLevel)
        {
        }
    }
}
