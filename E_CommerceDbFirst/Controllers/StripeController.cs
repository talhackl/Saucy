using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using E_CommerceDbFirst.Models;
using ServiceStack.Stripe;
using ServiceStack.Stripe.Types;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;
using System.Threading.Tasks;
using System.Net.Mail;
using System.Net;

namespace E_CommerceDbFirst.Controllers
{
    public class StripeController :Controller
    {
        //
        // GET: /Stripe/
        StripeGateway gateway;
        data_Base db;
        public StripeController()
        {
            gateway= new StripeGateway("sk_test_gmsesQcld5Dm19hk4qtN0yjJ");
            db = new data_Base();
        }

        //Methods Of Different Action

        public decimal amountCalculator(List<CartList> carts)
        {
            decimal amount = 0;
            foreach (var cart in carts)
            {
                var Item = db.Items.SingleOrDefault(i => i.ItemId == cart.ItemsId);
                var pricePerItem = Item.Price * Convert.ToDecimal(cart.ItemsQunatity);
                amount = amount + pricePerItem;
            }
            amount = amount * 100;
            return amount;
        }
        public bool saveCarts(Combo combo)
        {
            try
            {
                foreach (var cartlist in combo.cartlist)
                {
                    var dbcart = db.Carts.Where(c => c.ItemsId == cartlist.ItemsId && c.CustomerName == combo.stripe.UserName).SingleOrDefault();
                    if (dbcart == null)
                    {
                        db.saveNewCart(cartlist.ItemsQunatity, DateTime.Now.Date, cartlist.ItemsId, combo.stripe.UserName);
                        db.SaveChanges();
                    }
                    else
                    {
                        decimal quantity = dbcart.ItemsQunatity;
                        quantity = quantity + Convert.ToDecimal(cartlist.ItemsQunatity);
                        db.updateCart(dbcart.CartId, Convert.ToInt32(quantity));
                        db.SaveChanges();
                    }

                }
                return true;
            }
            catch (Exception e)
            {
                return false;
            }
        }
        public string sendEmail(string UserName,string EmailAddress,decimal amount)
        {
            try
            {
                amount = amount / 100;
                MailMessage message = new MailMessage();
                SmtpClient client = new SmtpClient();
                message.IsBodyHtml = true;
                message.From = new MailAddress("fastfood9699@gmail.com");
                message.To.Add(new MailAddress(EmailAddress));
                message.Body = "ThankYou  " + UserName + " For Trusting Us And Purchasing Fast Food From Our WebSite You've Done Purchasing Of " + amount + "$ Dollars";
                message.Subject = "SAUCY Purchasing";
                client.Host = "smtp.gmail.com";
                client.Port = 587;
                client.EnableSsl = true;
                client.UseDefaultCredentials = true;
                client.Credentials = new NetworkCredential("fastfood9699@gmail.com", "eLvisH9699");
                client.DeliveryMethod = SmtpDeliveryMethod.Network;
                client.Send(message);
                return "Done";
            }
            catch (Exception e)
            {
                return "Your Email Account Is Not Valid";
            }
        }
        //Methods Ended Here

        public ActionResult SignInPurchase()
        {
            return View();
        }
        [Authorize]
        public ActionResult LogInPurchase(Combo combo)
        {
            if (Request.IsAuthenticated)
            {
                var amount = new StripeController().amountCalculator(combo.cartlist);
                var username = User.Identity.GetUserName();
                var dbUser = db.AspNetUsers.SingleOrDefault(u => u.UserName == username);
                if (dbUser != null)
                {
                    try
                    {
                        var charge = gateway.Post(new ChargeStripeCustomer
                        {
                            Amount = Convert.ToInt32(amount),
                            Customer = dbUser.CustomerId,
                            Currency = "usd",
                            Description = "Fast Food Purchasing",
                        });
                    }
                    catch (Exception e)
                    {
                        return Json(new { success = false, responseText = "Error In Detecting Amount Check Your Amount", JsonRequestBehavior.AllowGet });
                    }
                    try
                    {
                        foreach (var cartlist in combo.cartlist)
                        {
                            var dbcart = db.Carts.Where(c => c.ItemsId == cartlist.ItemsId && c.CustomerName == dbUser.UserName).SingleOrDefault();
                            if (dbcart == null)
                            {
                                db.saveNewCart(cartlist.ItemsQunatity, DateTime.Now.Date, cartlist.ItemsId, dbUser.UserName);
                                db.SaveChanges();
                            }
                            else
                            {
                                decimal quantity = dbcart.ItemsQunatity;
                                quantity = quantity + Convert.ToDecimal(cartlist.ItemsQunatity);
                                db.updateCart(dbcart.CartId, Convert.ToInt32(quantity));
                                db.SaveChanges();
                            }

                        }
                    }
                    catch (Exception e)
                    {
                        return Json(new{ success = false, responseText = "Your Record Cart Is Not Added" },JsonRequestBehavior.AllowGet);
                    }

                    //Creating New Order 
                    try
                    {
                        foreach (var cartlist in combo.cartlist)
                        {
                            var date=DateTime.Now;
                            var dbitem=db.Items.Where(i => i.ItemId == cartlist.ItemsId).Single();
                            db.saveNewOrder(date, cartlist.ItemsId, dbitem.Price, dbUser.UserName, cartlist.ItemsQunatity);
                            db.SaveChanges();
                        }
                    }
                    catch (Exception e)
                    {

                    }



                    var Emailresult=new StripeController().sendEmail(dbUser.UserName, dbUser.Email, amount);
                    if(Emailresult != "Done")
                        return Json(new { success = false, responseText =Emailresult }, JsonRequestBehavior.AllowGet);

                }
            }
            return Json(new { success = true, responseText = "Problem With The Account" }, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public ActionResult New(Combo combo)
        {
            var customerId = "";

            var dbUser = db.AspNetUsers.Where(u => u.UserName == combo.stripe.UserName).SingleOrDefault();
            if(dbUser != null)
                return Json(new { success = false, responseText = "UserName Already Exists" }, JsonRequestBehavior.AllowGet);

            dbUser = null;
            dbUser = db.AspNetUsers.Where(u => u.Email == combo.stripe.EmailAddress).SingleOrDefault();
            if (dbUser != null)
                return Json(new { success = false, responseText = "Email Address Already Exists" }, JsonRequestBehavior.AllowGet);
            try
            {
                var cardToken = gateway.Post(new CreateStripeToken
                {
                    Card = new StripeCard
                    {

                        Name = combo.stripe.FirstName + combo.stripe.LastName,
                        Number = combo.stripe.CreditCard,
                        Cvc = combo.stripe.CVC,
                        ExpMonth = Convert.ToInt32(combo.stripe.ExpMonth),
                        ExpYear = Convert.ToInt32(combo.stripe.ExpYear),
                        AddressLine1 = combo.stripe.AddressLine1,
                        AddressLine2 = combo.stripe.AddressLine2,
                        AddressZip = combo.stripe.ZipCode,
                        AddressState = combo.stripe.State,
                        AddressCountry = combo.stripe.Country,
                    },
                });
                var customer = gateway.Post(new CreateStripeCustomerWithToken
                {
                    Card = cardToken.Id,
                    Description = "FastFood Items Purchasing",
                    Email = combo.stripe.EmailAddress,
                });
                customerId = customer.Id;
            }
            catch (Exception e)
            {
                return Json(new { success = false, responseText = "Enter Correct Information Of Credit Card" }, JsonRequestBehavior.AllowGet);
            }
            var amount = new StripeController().amountCalculator(combo.cartlist);
            try
            {
                var charge = gateway.Post(new ChargeStripeCustomer
                {
                    Amount = Convert.ToInt32(amount),
                    Customer = customerId,
                    Currency = "usd",
                    Description = "Fast Food Purchasing",
                });
            }
            catch (Exception e)
            {
                return Json(new { success = false, responseText = "Error In Detecting Amount" }, JsonRequestBehavior.AllowGet);
            }

            if (combo.stripe.UserName != null && customerId != "")
            {

                //Registering User
                try
                {
                    var UserStore = new UserStore<ApplicationUser>(new ApplicationDbContext());
                    var UserManager = new UserManager<ApplicationUser>(UserStore);
                    var User = new ApplicationUser()
                    {
                        UserName = Convert.ToString(combo.stripe.UserName),
                        Email = Convert.ToString(combo.stripe.EmailAddress),
                        PhoneNumber = Convert.ToString(combo.stripe.PhoneNo),
                        isDisable = false,
                        CustomerId = customerId
                    };
                    IdentityResult result = UserManager.Create(User, combo.stripe.Password);
                    if (!result.Succeeded)
                        return Json(new { success = false, responseText = "UserName Already Exists" }, JsonRequestBehavior.AllowGet);
                }
                catch (Exception e)
                {
                    return Json(new { success = false, responseText = "Error In Registering Account" }, JsonRequestBehavior.AllowGet);
                }
            }

            if (combo.stripe.UserName != null)
            {
                var value = new StripeController().saveCarts(combo);
                if (value == false)
                    return Json(new { success = false, responseText = "Your Record Cart Is Not Added" }, JsonRequestBehavior.AllowGet);
            }
            //Creating New Order 
            try
            {
                foreach (var cartlist in combo.cartlist)
                {
                    var date = DateTime.Now;
                    var name = "";
                    if (combo.stripe.UserName != null)
                        name = combo.stripe.UserName;
                    else
                        name = combo.stripe.FirstName + combo.stripe.LastName;

                    var dbitem = db.Items.Where(i => i.ItemId == cartlist.ItemsId).Single();
                    db.saveNewOrder(date, cartlist.ItemsId, dbitem.Price, name, cartlist.ItemsQunatity);
                    db.SaveChanges();
                }
            }
            catch (Exception e)
            {

            }


            var Emailname = "";
            if (combo.stripe.UserName != null)
                Emailname = combo.stripe.UserName;
            else
                Emailname = combo.stripe.FirstName + combo.stripe.LastName;
            var Emailresult = new StripeController().sendEmail(Emailname, combo.stripe.EmailAddress, amount);
            if (Emailresult != "Done")
                return Json(new { success = false, responseText = Emailresult }, JsonRequestBehavior.AllowGet);

            




            return Json(new { success = true, responseText = "Purchasing Successfull" }, JsonRequestBehavior.AllowGet);
        }
	}
}