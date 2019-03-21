using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace E_CommerceDbFirst.Models
{
    public class LogIn
    {
        [Required(ErrorMessage="UserName Is Required")]
        public string UserName { get; set; }

        [Required(ErrorMessage="Password Is Required")]
        public string Password { get; set; }
    }
}