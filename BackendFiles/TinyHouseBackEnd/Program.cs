using System;
using System.Collections.Generic;
using TinyHouseBackEnd.UserPackage;

namespace TinyHouseBackEnd
{
    class Program
    {
        static void Main(string[] args)
        {
            //Test Codes 
            /*
            AbsUser user = AbsUser.UserFactory.Login("Berat", "12345");
            if (user!=null)
            {
                if (user.UserRoleLevel == 0)
                {
                    Console.WriteLine("Admin giriş yaptı.");
                }
                else if (user.UserRoleLevel == 1)
                {
                    Console.WriteLine("Ev sahibi giriş yaptı.");
                }
                else if (user.UserRoleLevel == 2)
                {
                    Console.WriteLine("Kiracı giriş yaptı.");
                }
            }
            else
            {
                Console.WriteLine("Giriş başarısız.");
            }
            

            
            AbsUser user2 = AbsUser.UserFactory.Register("User2","password2","mail2","number2","address2",1);
            if (user2 != null)
            {
                Console.WriteLine("Kayıt başarılı.");
            }
            else
            {
                Console.WriteLine("Kayıt başarısız.");
            }
            
            
            user2.UpdateProfile("newusername", "newpassword", "newmail", "newphone", "newaddress");
            
            
            user2.UnRegister();

            user2.ChangePassword("new2password");
            
            */
        }
    }
}
    

