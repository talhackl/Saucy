using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace E_CommerceDbFirst.Models.Validation
{
    public class PasswordValidation : ValidationAttribute
    {
        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            var stripe = (Stripe)validationContext.ObjectInstance;
            if (stripe.Confirmpassword != null)
            {
                //Card Numbers
                if (stripe.Password == stripe.Confirmpassword)
                    return ValidationResult.Success;
                else
                    return new ValidationResult("Password DoesNot Match");
            }
            else
            {
                return new ValidationResult("Password Must Be Entered");
            }
        }
    }
}