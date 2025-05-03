using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TinyHouseBackEnd.UserPackage
{
    internal class HomeOwner : AbsUser
    {
        public HomeOwner(string userName, string password, string email, string phoneNumber, string address, int userRoleLevel)
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
