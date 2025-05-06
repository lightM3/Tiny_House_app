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

            AbsUser user = AbsUser.UserFactory.Login("Murat", "4321");
            if (user != null)
            {
                if (user.UserRoleLevel == 0)
                {
                    Console.WriteLine("Admin giriş yaptı.");
                }
                else if (user.UserRoleLevel == 1)
                {
                    Console.WriteLine("Ev sahibi giriş yaptı.");
                    if (user is HomeOwner owner)
                    {
                        //owner.addHouse(500, "Adana Merkez", "Merkezde patlayan 3+1", houseAvgStar: 5.2,isAvaiable:true);
                        //owner.makeActiveHouse(1);
                        //owner.makePassiveHouse(2);
                        //owner.listMyHouse();
                        //owner.listHouseCommands(1);
                        owner.updateHousePrice(4, 250);
                        //owner.unAddHouse(3);
                        //owner.listMyHouse();
                    }


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





        }
    }
}
    

