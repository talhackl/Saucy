using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace E_CommerceDbFirst.Models.Validation
{
    public class ExpYearValidation : ValidationAttribute
    {
        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            var stripe = (Stripe)validationContext.ObjectInstance;
            if (stripe.ExpYear != null)
            {
                //Card Numbers
                if (stripe.ExpYear.Length != 4)
                    return new ValidationResult("Year Must Be Of 4 Digits");
                else
                    return ValidationResult.Success;
            }
            else
            {
                return new ValidationResult("Expiry Year Must Be Entered");
            }
        }
    }
}