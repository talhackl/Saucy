using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using E_CommerceDbFirst.Models.Validation;

namespace E_CommerceDbFirst.Models
{
    public class Stripe
    {
        [Required(ErrorMessage = "First Name Is Required")]
        public string FirstName { get; set; }

        [Required(ErrorMessage = "Last Name Is Required")]
        public string LastName { get; set; }
        

        [Display(Name="Credit Card Number")]
        [Required(ErrorMessage = "Credit Card Number Is Required")]
        [CreditCardValidation]
        public string CreditCard { get; set; }
        

        [Required(ErrorMessage = "CVC Is Required")]
        [CVCValidation]
        public string CVC { get; set; }

        [Required(ErrorMessage = "EmailAddress Is Required")]
        public string EmailAddress { get; set; }

        [Display(Name="Expiry Month of Card")]
        [Required(ErrorMessage = "Expiry Month of Card Is Required")]
        [ExpMonthValidation]
        public string ExpMonth { get; set; }

        [Display(Name = "ExpiryYear Of Card")]
        [Required(ErrorMessage = "ExpiryYear Of Card Is Required")]
        [ExpYearValidation]
        public string ExpYear { get; set; }

        [Display(Name = "Permanent Address")]
        [Required(ErrorMessage = "Permanent Address Is Required")]
        public string AddressLine1 { get; set; }

        [Display(Name = "Temporary Address")]
        [Required(ErrorMessage = "Temporary Address Is Required")]
        public string AddressLine2 { get; set; }

        [Required(ErrorMessage = "ZipCode Is Required")]
        public string ZipCode { get; set; }

        [Required(ErrorMessage = "State Is Required")]
        public string State { get; set; }

        [Required(ErrorMessage = "Country Is Required")]
        public string Country { get; set; }

        [Required(ErrorMessage = "UserName Is Required")]
        public string UserName { get; set; }

        [Required(ErrorMessage = "Password Is Required")]
        public string Password { get; set; }

        [Required(ErrorMessage = "Confirmpassword Is Required")]
        [PasswordValidation]
        public string Confirmpassword { get; set; }

        [Required(ErrorMessage = "PhoneNo Is Required")]
        public string PhoneNo { get; set; }
        
    }
}