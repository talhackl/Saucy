using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace E_CommerceDbFirst.Models.Validation
{
    public class ExpMonthValidation : ValidationAttribute
    {
        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            var stripe = (Stripe)validationContext.ObjectInstance;
            if (stripe.ExpMonth != null)
            {
                //Card Numbers
                if (stripe.ExpMonth.Length != 2)
                    return new ValidationResult("Month Must Be Of 2 Digits");
                else
                    return ValidationResult.Success;
            }
            else
            {
                return new ValidationResult("Expiry Month Must Be Entered");
            }
        }
    }
}