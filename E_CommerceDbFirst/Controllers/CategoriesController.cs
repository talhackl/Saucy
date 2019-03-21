using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using E_CommerceDbFirst.Models;
namespace E_CommerceDbFirst.Controllers
{
    [Authorize]
    public class CategoriesController : Controller
    {
        public ActionResult Index()
        {
            if (User.IsInRole(Role.Manager))
            {
                return View();
            }
            return RedirectToAction("Register", "Accounts");
        }
        public ActionResult New()
        {
            if (User.IsInRole(Role.Manager))
            {
                return View();
            }
            return RedirectToAction("Register", "Accounts");
        }
	}
}