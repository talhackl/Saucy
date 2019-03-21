using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;

namespace E_CommerceDbFirst
{
    public class BundleConfig{
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(

                        "~/Scripts/jquery-{version}.js",
                        "~/Scripts/bootstrap-datepicker.js",
                        "~/Scripts/DataTables/jquery.dataTables.js",
                        "~/Scripts/jquery.cookie-1.4.1.min.js",
                        //"~/Scripts/bootstrap.js",
                        "~/Scripts/typeahead.bundle.js",
                        "~/Scripts/toastr.min.js",
                        "~/Scripts/bootbox.js",
                        "~/Scripts/DataTables/dataTables.bootstrap4.js"
                        ));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.validate*"));
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

           
            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/bootstrap.css",
                      "~/Content/bootstrap-datepicker.css",
                      "~/Content/typeahead.css",
                      "~/Content/toastr.css",
                     "~/Content/DataTables/css/dataTables.bootstrap4.css",
                      "~/Content/Site.css"
                      ));
        }
    }
}