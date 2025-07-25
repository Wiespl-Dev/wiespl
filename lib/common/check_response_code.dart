
import 'package:flutter/material.dart';
import 'package:wiespl/utils/widget.dart';

import 'utils.dart';

class CheckResponseCode {
  static void getResponseCode(int code, BuildContext context) {
    String msg = "";

    switch (code) {
      case 0:
        {
          msg = "Something went wrong please try again";
        }
        break;
      case 100:
        {
          msg = "Continue";
        }
        break;
      case 101:
        {
          msg = "Switching Protocols";
        }
        break;
      case 103:
        {
          msg = "Early Hints";
        }
        break;

      case 200:
        {
          msg = "OK";
        }
        break;
      case 201:
        {
          msg = "Created";
        }
        break;
      case 202:
        {
          msg = "Accepted";
        }
        break;
      case 203:
        {
          msg = "Non-Authoritative Information";
        }
        break;
      case 204:
        {
          msg = "Data Not Available.!";
        }
        break;
      case 205:
        {
          msg = "Reset Content";
        }
        break;
      case 206:
        {
          msg = "Partial Content";
        }
        break;

      case 300:
        {
          msg = "Multiple Choices";
        }
        break;
      case 301:
        {
          msg = "Moved Permanently";
        }
        break;
      case 302:
        {
          msg = "Found";
        }
        break;
      case 303:
        {
          msg = "See Other";
        }
        break;
      case 304:
        {
          msg = "Not Modified";
        }
        break;
      case 307:
        {
          msg = "Temporary Redirect";
        }
        break;
      case 308:
        {
          msg = "Permanent Redirect";
        }
        break;

      case 400:
        {
          msg = "Bad Request";
        }
        break;
      case 401:
        {
          //   msg = "Unauthorized";
          Utils.logoutUser401(context, "Please sign in again");
          return;
        }
        break;
      case 402:
        {
          msg = "Payment Required";
        }
        break;
      case 403:
        {
          msg = "Forbidden";
        }
        break;
      case 404:
        {
          msg = "Data Not Available.!";
        }
        break;
      case 405:
        {
          msg = "Method Not Allowed";
        }
        break;
      case 406:
        {
          msg = "Not Acceptable";
        }
        break;
      case 407:
        {
          msg = "Proxy Authentication Required";
        }
        break;
      case 408:
        {
          msg = "Request Timeout";
        }
        break;
      case 409:
        {
          msg = "Conflict";
        }
        break;
      case 410:
        {
          msg = "Gone";
        }
        break;
      case 411:
        {
          msg = "Length Required";
        }
        break;
      case 412:
        {
          msg = "Precondition Failed";
        }
        break;
      case 413:
        {
          msg = "Payload Too Large";
        }
        break;
      case 414:
        {
          msg = "URI Too Long";
        }
        break;
      case 415:
        {
          msg = "Unsupported Media Type";
        }
        break;
      case 416:
        {
          msg = "Range Not Satisfiable";
        }
        break;
      case 417:
        {
          msg = "Expectation Failed";
        }
        break;
      case 418:
        {
          msg = "I'm a teapot";
        }
        break;
      case 422:
        {
          msg = "Unprocessable Entity";
        }
        break;
      case 425:
        {
          msg = "Too Early";
        }
        break;
      case 426:
        {
          msg = "Upgrade Required";
        }
        break;
      case 428:
        {
          msg = "Precondition Required";
        }
        break;
      case 429:
        {
          msg = "Too Many Requests";
        }
        break;
      case 431:
        {
          msg = "Request Header Fields Too Large";
        }
        break;
      case 451:
        {
          msg = "Unavailable For Legal Reasons";
        }
        break;

      case 500:
        {
          msg = "Fail to connect server";
        }
        break;
      case 501:
        {
          msg = "Not Implemented";
        }
        break;
      case 502:
        {
          msg = "Bad Gateway";
        }
        break;
      case 503:
        {
          msg = "service_unavailable";
        }
        break;
      case 504:
        {
          msg = "Gateway Timeout";
        }
        break;
      case 505:
        {
          msg = "HTTP Version Not Supported";
        }
        break;
      case 506:
        {
          msg = "Variant Also Negotiates";
        }
        break;
      case 507:
        {
          msg = "Insufficient Storage";
        }
        break;
      case 508:
        {
          msg = "Loop Detected";
        }
        break;
      case 511:
        {
          msg = "Network Authentication Required";
        }
        break;
    }
    //toastMassage(msg);
  }
}
