using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;
using System.Threading.Tasks;
using E_CommerceDbFirst.Models;
using ServiceStack.Stripe;
using ServiceStack.Stripe.Types;
using System.Net;

namespace E_CommerceDbFirst.Controllers
{
   
    public class AccountsController : Controller
    {
        StripeGateway gateway;
        public AccountsController()
        {
            gateway = new StripeGateway("sk_test_gmsesQcld5Dm19hk4qtN0yjJ");
        }
        
        public ActionResult AccountsIndex()
        {
            if (User.IsInRole(Role.Manager))
            {
                return View();
            }
            return RedirectToAction("index", "Items");
        }
        
        public ActionResult Register()
        {
            if (Request.IsAuthenticated)
            {
                return RedirectToAction("Index", "Items");
            }
                return View();
        }

        //Accounts/Register
        [HttpPost]
        [AllowAnonymous]
        public async Task<ActionResult> Register(Stripe model)
        {
            if (!ModelState.IsValid)
            {
                return View("Register", model);
            }
            var UserStore = new UserStore<ApplicationUser>(new ApplicationDbContext());
            var UserManager = new UserManager<ApplicationUser>(UserStore);
            var dbUser= await UserManager.FindByNameAsync(model.UserName);
            if (dbUser != null)
            {
                ViewBag.RegisterError = "UserName Already Exists";
                return View("Register", model);
            }
            dbUser = null;
            dbUser = await UserManager.FindByEmailAsync(model.EmailAddress);
            if (dbUser != null)
            {
                ViewBag.RegisterError = "Email Already Exists";
                return View("Register", model);
            }
            try
            {
                var cardToken = gateway.Post(new CreateStripeToken
                {
                    Card = new StripeCard
                    {

                        Name = model.FirstName + model.LastName,
                        Number = model.CreditCard,
                        Cvc = model.CVC,
                        ExpMonth = Convert.ToInt32(model.ExpMonth),
                        ExpYear = Convert.ToInt32(model.ExpYear),
                        AddressLine1 = model.AddressLine1,
                        AddressLine2 = model.AddressLine2,
                        AddressZip = model.ZipCode,
                        AddressState = model.State,
                        AddressCountry = model.Country,
                    },
                });
                var customer = gateway.Post(new CreateStripeCustomerWithToken
                {
                    Card = cardToken.Id,
                    Description = "FastFood Items Purchasing",
                    Email = model.EmailAddress,
                });

                var User = new ApplicationUser()
                {
                    UserName = model.UserName,
                    Email = model.EmailAddress,
                    PhoneNumber = model.PhoneNo,
                    isDisable = false,
                    CustomerId = customer.Id
                };
                IdentityResult result = await UserManager.CreateAsync(User, model.Password);
                if (result.Succeeded)
                {
                    //I Created The Role FOr SuperAdmin

                    //var RoleStore = new RoleStore<IdentityRole>();
                    //var RoleManager = new RoleManager<IdentityRole>(RoleStore);
                    //var Role = new IdentityRole()
                    //{
                    //    Name = "CanManageWebSite"
                    //};
                    //await RoleManager.CreateAsync(Role);
                    //await UserManager.AddToRoleAsync(User.Id, Role.Name);
                    var AuthenticationManager = System.Web.HttpContext.Current.GetOwinContext().Authentication;
                    var UserIdentity = await UserManager.CreateIdentityAsync(User, DefaultAuthenticationTypes.ApplicationCookie);
                    AuthenticationManager.SignIn(new AuthenticationProperties() { IsPersistent = false }, UserIdentity);
                    return RedirectToAction("Index", "Items");
                }
                else
                {
                    ViewBag.RegisterError = "Password Format Is Not Correct";
                    return View("Register", model);
                } 
            }
            catch (Exception ety)
            {
                ViewBag.RegisterError = " Enter Correct Information Of Credit Card ";
                return View("Register", model);
            }
            
            
        }

        //Accounts/Login
        [AllowAnonymous]
        public ActionResult Login()
        {
            if (Request.IsAuthenticated)
            {
                return RedirectToAction("Index", "Items");
            }
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Login(LogIn model)
        {
            if (Request.IsAuthenticated)
            {
                return RedirectToAction("Index", "Items");
            }
            if (!ModelState.IsValid)
                return View("Login", model);
            try
            {
                var UserStore = new UserStore<IdentityUser>();
                var UserManager = new UserManager<IdentityUser>(UserStore);
                var User = await UserManager.FindAsync(model.UserName, model.Password);
                if (User != null)
                {
                    using (var db = new data_Base())
                    {
                        var dbUser = db.AspNetUsers.Single(u => u.Id == User.Id);
                        if (dbUser.IsDisable == false)
                        {
                            var AuthenticationManager = System.Web.HttpContext.Current.GetOwinContext().Authentication;
                            var UserIdentity = await UserManager.CreateIdentityAsync(User, DefaultAuthenticationTypes.ApplicationCookie);
                            AuthenticationManager.SignIn(new AuthenticationProperties() { IsPersistent = false }, UserIdentity);
                            return RedirectToAction("Index", "Items");
                        }
                        else if (dbUser.IsDisable == true)
                        {
                            ViewBag.Account = "Your Account Is Locked";
                            return View(model);
                        }
                    }
                }
                ViewBag.UserError = "UserName And Password DoesNot Match";
                return View(model);
            }
            catch (Exception e)
            {
                ViewBag.RegisterError = "Error While Loggin Your Account ";
                return View("Register", model);
            }
        }

        //Accounts/Logout
        [Authorize]
        public ActionResult Logout()
        {
            
                var AuthenticationManager = System.Web.HttpContext.Current.GetOwinContext().Authentication;
                AuthenticationManager.SignOut();
                return RedirectToAction("Login", "Accounts");
        }
	}
}