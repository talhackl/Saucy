using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

namespace E_CommerceDbFirst.Models
{
    public class CreditCardValidation : ValidationAttribute
    {
        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            var stripe = (Stripe)validationContext.ObjectInstance;
            if (stripe.CreditCard != null)
            {
                //Card Numbers
                if (stripe.CreditCard.Length != 16)
                    return new ValidationResult("Card Digits Must Be Of 16 Digits");
                else
                    return ValidationResult.Success;
            }
            else
            {
                return new ValidationResult("Credit Card Must Be Entered");
            }
        }
    }
}