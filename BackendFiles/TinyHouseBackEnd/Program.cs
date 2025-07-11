﻿using System;
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

            AbsUser user = AbsUser.UserFactory.Login("owner3", "owner123");
            if (user != null)
            {
                //show loginned userid, username, 
                Console.WriteLine($"UserId: {user.UserId}, UserName: {user.UserName}");

                if (user.UserRoleLevel == 0)
                {
                    Console.WriteLine("Admin giriş yaptı.");
                    if (user is Admin admin)
                    {

                        //admin.AddNewAccount("Hadise", "HadiseSifre", "Hadise@mail.com", "+905552229944", "İzmir Gaziemir, Turkey", 1);
                        //admin.DeleteAccount(17);
                        //admin.MakePassiveAccount(4);
                        //admin.MakeActiveAccount(18);
                        //admin.UpdateAccount(18, "Aleyna", "AleynaSifre", "Aleyna@mail.com", "+905556667788", "Iğdır, Turkey");
                        //admin.DeleteHouse(4);
                        //admin.MakeActiveHouse(2);
                        //admin.MakePassiveHouse(4);
                        //admin.ListAllResetvations();

                        //admin.ListAllPayments();

                        //admin.MakeUserPassiveBetweenDates(1, DateTime.Now, DateTime.Now.AddDays(10));
                        //admin.MakeActiveAccount(1);
                    }

                }
                else if (user.UserRoleLevel == 2)
                {
                    Console.WriteLine("Ev sahibi giriş yaptı.");
                    
                    if (user is HomeOwner owner)
                    {

                        //owner.addHouse(500, "Adana Merkez", "Merkezde patlayan 3+1", houseAvgStar: 5.2,isAvaiable:true);
                        //owner.makeActiveHouse(1);
                        //owner.MakePassiveHouse(3,DateTime.Now,DateTime.Now.AddDays(2));
                        //owner.listMyHouse();
                        //owner.ListHouseCommands(3);
                        //owner.updateHousePrice(4, 250);
                        //owner.unAddHouse(3);
                        //owner.listMyHouse();
                        //owner.listHouseCommands(2); //

                        //owner.ListWaitingReservation();
                        //owner.ConfirmReservation(11);
                        //owner.ListWaitingReservation();
                        //owner.RejectReservation(9);
                        //owner.ListWaitingReservation();
                        //owner.ListAllReservationForHouse(3);
                        //owner.ListAllReservationForHouse(4);

                        //owner.ListWaitingReservation();



                    }


                }
                else if (user.UserRoleLevel == 1)
                {
                    Console.WriteLine("Kiracı giriş yaptı.");
                    if (user is Tenant tenant) 
                    {

                        //tenant.listAvailableHouses();
                        //tenant.RentHouse(4);
                        //tenant.UnRentHouse(4);
                        //tenant.listAvailableHouses();
                        //tenant.RentHouse(5);
                        //tenant.listAvailableHouses();
                        //tenant.AddComment(4, "Tekrar geldim yine memnun kaldım Çok iyi bir Ev :)", 3);
                        //tenant.listAvailableHouses();
                        //tenant.RentHouse(6);
                        //tenant.AddComment(6, "Bornovada olması Güzeldi", 88);

                        //tenant.ListAvailableHouses();
                        //tenant.MakeReservations(6, DateTime.Now, DateTime.Now.AddDays(7));
                        //tenant.MakeReservations(4, DateTime.Now, DateTime.Now.AddDays(7));

                        //tenant.ListMyReservations();
                        //tenant.ListAvailableHouses();

                        //tenant.CancelMyReservation(3);

                        //tenant.MakePayment(10, 750, "Debid Card");

                    }

                }
            }
            else
            {
                Console.WriteLine("Giriş başarısız.");
            }





        }
    }
}
    

