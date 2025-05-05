using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TinyHouseBackEnd.UserPackage
{
    internal class Tenant : AbsUser
    {
        public Tenant() { } // Default constructor
        public Tenant(string userName, string password, string email, string phoneNumber, string address , int userRoleLevel)
            : base(userName, password, email, phoneNumber, address, userRoleLevel)
        {
        }
    }
}
