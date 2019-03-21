using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace E_CommerceDbFirst.Models.Validation
{
    public class CVCValidation : ValidationAttribute
    {
        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            var stripe = (Stripe)validationContext.ObjectInstance;
            if (stripe.CVC != null)
            {
                //Card Numbers
                if (stripe.CVC.Length != 3)
                    return new ValidationResult("CVC Must Be Of 3 Digits");
                else
                    return ValidationResult.Success;
            }
            else
            {
                return new ValidationResult("CVC Must Be Entered");
            }
        }
    }
}