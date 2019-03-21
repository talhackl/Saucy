using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using E_CommerceDbFirst.Models;

namespace E_CommerceDbFirst.Models
{
    public class Combo
    {
        public Stripe stripe { get; set; }
        public List<CartList> cartlist { get; set; }
    }
}