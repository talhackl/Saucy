using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace E_CommerceDbFirst.Controllers
{
    public class HomeController : Controller
    {
        [AllowAnonymous]
        public ActionResult LandPage()
        {
            return View();
        }
	}
}