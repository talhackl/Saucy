using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using E_CommerceDbFirst.Models;
using System.IO;


namespace E_CommerceDbFirst.Controllers
{
    public class ItemsController : Controller
    {
        
        [AllowAnonymous]
        
        public ActionResult Index()
        {

            return View();
        }
        [AllowAnonymous]
        public ActionResult Show()
        {
            
            return View();
        }

        public ActionResult New()
        {
            if (User.IsInRole(Role.Manager))
                return View();
            else
                return RedirectToAction("Index", "Items");
        }

        public ActionResult Delete()
        {
            if (User.IsInRole(Role.Manager))
                return View();
            else
                return RedirectToAction("Index", "Items");
        }
	}
}