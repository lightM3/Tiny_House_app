using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TinyHouseBackEnd
{
    internal class House
    {
        public int houseId { get; set; }
        public int ownerId { get; set; }
        public int price { get; set; }
        public string houseLocation { get; set; }
        public string houseDescription { get; set; }
        public double houseAvgStar { get; set; }
        public bool isAvaiable  { get; set; }



        public House(int ownerId, int price, string houseLocation, string houseDescription, double houseAvgStar, bool isAvaiable)
        {
            this.ownerId = ownerId;
            this.price = price;
            this.houseLocation = houseLocation;
            this.houseDescription = houseDescription;
            this.houseAvgStar = houseAvgStar;
            this.isAvaiable = isAvaiable;
        }
    }
}
