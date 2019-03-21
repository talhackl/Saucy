using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace E_CommerceDbFirst.Controllers
{
    public class OrdersController : Controller
    {
        //
        // GET: /Orders/
        public ActionResult ViewOrders()
        {
            return View();
        }
	}
}