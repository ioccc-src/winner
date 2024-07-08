<?
class Date 
{
	var $date;
	var $time;

	//
	// Create a new date object set to the time now.
	//
	function Date()
	{
		$this->setTime(time());
	}

	function isLeapYear(/* year */) 
	{
		if (func_num_args() == 1)
			$year = func_get_arg(0);
		else 
			$year = $this->date['year'];

		if ($year % 4000 == 0)
			return false;
		if ($year % 400 == 0)
			return true;
		if ($year % 100 == 0)
			return false;
		if ($year % 4 == 0)
			return true;
		return false;
	}

	//
	// Return the number of seconds since system epoch.
	//
	function getTime() 
	{
		return $this->time;
	}

	//
	// Set the date / time in seconds for the object.
	//
	function setTime($t) 
	{
		$this->time = $t;
		$this->date = getdate($t);
	}

	function getHour() 
	{
		return $this->date['hour'];
	}

	function getMinute() 
	{
		return $this->date['minutes'];
	}

	function getSecond() 
	{
		return $this->date['seconds'];
	}

	function getMonth() 
	{
		return $this->date['mon'];
	}

	function getYear() 
	{
		return $this->date['year'];
	}

	function getDayOfWeek() 
	{
		return $this->date['wday'];
	}

	function getDayOfMonth() 
	{
		return $this->date['mday'];
	}

	function getDayOfYear() 
	{
		return $this->date['yday'];
	}

	function getDaysInMonth(/* year, month */)
	{
		if (func_num_args() == 2) {
			$year = func_get_arg(0);
			$month = func_get_arg(1);
		} else {
			$year = $this->date['year'];
			$month = $this->date['mon'];
		}

		$endOfMonth = Array(
			31,
			28 + Date::isLeapYear($year),
			31,
			30,
			31,
			30,
			31,
			31,
			30,
			31,
			30,
			31
		);

		return $endOfMonth[$month-1];
	}

	function getPreviousMonth()
	{
		if ($this->date['mon'] <= 1)
			return 12;
			
		return $this->date['mon']-1;
	}

	function getNextMonth()
	{
		if (12 <= $this->date['mon'])
			return 1;
			
		return $this->date['mon']+1;
	}
	
	function getFirstWeekDayOfMonth(/* year, month */)
	{
		if (func_num_args() == 2) {
			$y = func_get_arg(0);
			$m = func_get_arg(1);
		} else {
			$y = $this->date['year'];
			$m = $this->date['mon'];
		}
			
		// Day of the week 0..6 (Sunday..Saturday).
		$weekDay = strftime("%w", mktime(0, 0, 0, $m, 1, $y));
		
		// Day of the week 1..7 (Monday..Sunday).
		return $weekDay == 0 ? 7 : $weekDay;
	}	

	function getNumberOfWeeks(/* year */)
	{
		if (func_num_args() == 1)
			$year = func_get_arg(0);
		else
			$year = $this->date['year'];

		/* An ISO calendar year y is long (contains 53 weeks) if:
		 * 
		 *	p(y) modulo 7 = 4
		 * 
		 * or if:
		 * 
		 *	p(y-1) modulo 7 = 3
		 *
		 * with:
		 * 
		 *	p(y) = y + floor(y/4) - floor(y/100) + floor(y/400)
		 *
		 * http://www.phys.uu.nl/~vgent/calendar/isocalendar.htm
		 */						

		if (($year + floor($year/4) - floor($year/100) + floor($year/400)) % 7 == 4)
			return 53;
				
		if ((--$year + floor($year/4) - floor($year/100) + floor($year/400)) % 7 == 3)
			return 53;
						
		return 52;
	}

	/* 
	 * Return ISO 8601:2000(E) week number. This is a work around for
	 * Windows, which does not support a working strftime %V format.
	 */
	function getWeekNumber(/* year, month, day */)
	{
		if (func_num_args() == 3) {
			$year = func_get_arg(0);
			$month = func_get_arg(1);
			$day = func_get_arg(2);
		} else {
			$year = $this->date['year'];
			$month = $this->date['mon'];
			$day = $this->date['mday'];
		}

        /* The week number of the current year as a decimal number, range
         * 00 to 53, starting with the first Monday as the first day of
         * week 01.
         */
		$week = strftime("%W", mktime(0, 0, 0, $month, $day, $year));
		
		/* Week days numbered 0 (Sunday) to 6 (Saturday). */
		$firstWeekDayThisYear = strftime("%w", mktime(0, 0, 0, 1, 1, $year));
		$firstWeekDayNextYear = strftime("%w", mktime(0, 0, 0, 1, 1, $year+1));

		/* The first ISO calendar week of a year is the one that includes the 
		 * first Thursday of that year. In other words, the first week of the
		 * ISO calendar year is the earliest week that contains at least four
		 * days of the month of January.
		 */
		if (1 < $firstWeekDayThisYear && $firstWeekDayThisYear < 5) {
			/* The first Thursday of the current ISO year was in week zero. */
			$week++;
		} 
		
		if ($week == 53 && 1 < $firstWeekDayNextYear && $firstWeekDayNextYear < 5) {
			/* The first Thursday of the following ISO year is this week. */
			$week = 1;
		}
		
		if ($week == 0) {
			/* Number of weeks last year. */
			$week = Date::getNumberOfWeeks($year-1);
		}

		return $week+0;
	}

	//
	// Return the number seconds as of zero hour today.
	//
	function getDate()
	{
		return mktime(0, 0, 0, $this->date['mon'], $this->date['mday'], $this->date['year']);
	}

	//
	// Set date as of zero hour that day.
	//
	function setDate($year, $month, $day)
	{
		$this->setDateTime($year, $month, $day, 0, 0, 0);
	}

	//
	// Return the date / time array.
	//
	function getDateTime() 
	{
		return $this->date;
	}

	//
	// Set the date / time for the object.
	//
	function setDateTime($year, $month, $day, $hour, $minute, $second) 
	{
		$time = mktime($hour, $minute, $second, $month, $day, $year, 0);
		$this->setTime($time);
	}

	//
	// Adjust the date / time of the object.
	//
	function addDateTime($year, $month, $day, $hour, $minute, $second) 
	{
		$t = mktime(
			$this->date['hour'] + $hour,
			$this->date['minutes'] + $minute,
			$this->date['seconds'] + $second,
			$this->date['mon'] + $month,
			$this->date['mday'] + $day,
			$this->date['year'] + $year
		);
		$this->setTime($t);
	}

	//
	// Return the date / time as an ISO date string.
	//
	function getDateISO() 
	{
		return strftime("%Y-%m-%d %H:%M:%S", $this->time);
	}

	//
	// Set the date / time of the object using an ISO date string.
	//
	function setDateISO($str) 
	{
		if (!ereg('([0-9]+)-([0-9]+)-([0-9]+)', $str, $ymd))
			$ymd = array('','0','0','0');
		if (!ereg('([0-9]+):([0-9]+):([0-9]+)\+([0-9]+)', $str, $hms))
			$hms = array('','0','0','0');

		// Assume local time, ignore timezone.
		$this->setDateTime(
			intval($ymd[1]),
			intval($ymd[2]),
			intval($ymd[3]),
			intval($hms[1]),
			intval($hms[2]),
			intval($hms[3])
		);
	}

	function setDateMySQL($str) 
	{
		$n = sscanf($str, "%4d%2d%2d%2d%2d%2d", $y, $m, $d, $H, $M, $S);
		$this->setDateTime($y, $m, $d, $H, $M, $S);
	}

	//
	// Relational operations between Date vs time or Date vs Date.
	//
	function eq($t) 
	{
		if (is_object($t)) $t = $t->getTime();
		return $this->time == $t;
	}

	function ne($t) 
	{
		if (is_object($t)) $t = $t->getTime();
		return $this->time != $t;
	}

	function lt($t) 
	{
		if (is_object($t)) $t = $t->getTime();
		return $this->time < $t;
	}

	function le($t) 
	{
		if (is_object($t)) $t = $t->getTime();
		return $this->time <= $t;
	}

	function gt($t) 
	{
		if (is_object($t)) $t = $t->getTime();
		return $this->time > $t;
	}

	function ge($t) 
	{
		if (is_object($t)) $t = $t->getTime();
		return $this->time >= $t;
	}

	/*
	 * $obj->getSmallCalendar()
	 * Date::getSmallCalendar($year, $month)
	 */
	function getSmallCalendar(/* [$year, $month] */)
	{
		if (func_num_args() == 2) {
			$year = func_get_arg(0);
			$month = func_get_arg(1);
		} else {
			$year = $this->date['year'];
			$month = $this->date['mon'];
		}
		
		$name = date('F', mktime(0,0,0,$month,1,$year));
		$weekNumber = Date::getWeekNumber($year, $month, 1);
		$daysInMonth = Date::getDaysInMonth($year, $month);	
		$weekDay = Date::getFirstWeekDayOfMonth($year, $month) - 1;

		$thisDate = getdate(time());
		$thisDay = mktime(0, 0, 0, $thisDate['mon'], $thisDate['mday'], $thisDate['year']);
		$thisWeek = Date::getWeekNumber($thisDate['year'], $thisDate['mon'], $thisDate['mday']);

		if ($year != $thisDate['year']) {
			$thisWeek = 0;
		}
	
		$rc = <<<EOT
<table class="smCalendarTable">
<tr>
	<td class="smCalendarCell smCalendarMonthTitle" colspan="8" align="center">{$name} &nbsp; {$year}</td>
</tr>
<tr>
	<td class="smCalendarCell smCalendarDayTitle">&nbsp;</td>
	<td class="smCalendarCell smCalendarDayTitle">Mo</td>
	<td class="smCalendarCell smCalendarDayTitle">Tu</td>
	<td class="smCalendarCell smCalendarDayTitle">We</td>
	<td class="smCalendarCell smCalendarDayTitle">Th</td>
	<td class="smCalendarCell smCalendarDayTitle">Fr</td>
	<td class="smCalendarCell smCalendarDayTitle">Sa</td>
	<td class="smCalendarCell smCalendarDayTitle">Su</td>
</tr>
<tr>
	<td class="smCalendarCell smCalendarWeekNumber" valign='top'>{$weekNumber}</td>

EOT;

		if ($weekNumber == $thisWeek) {
			$style = "smCalendarThisWeek";
			$thisDayStyle = "smCalendarThisWeek smCalendarThisDay";
		} else {
			$style = $thisDayStyle = "smCalendarDay";
		}
		
		for ($i = 0; $i < $weekDay; $i++) {
			$rc .= sprintf(
				"\t<td class='smCalendarCell %s%s'>&nbsp;</td>\n", 
				$i == $thisDate['wday'] ? $thisDayStyle : $style, 
				$i < 5 ? "" : " smCalendarWeekend"
			);
		}
	
		for ($i = 1; $i <= $daysInMonth; $i++, $weekDay = ($weekDay + 1) % 7) {
			if (1 < $i && $weekDay == 0) {
				$weekNumber = Date::getWeekNumber($year, $month, $i);

				$week = $weekNumber < 10 ? "&nbsp;&nbsp;{$weekNumber}" : $weekNumber;
				$rc .= "</tr>\n<tr>\n\t<td class='smCalendarCell smCalendarWeekNumber' valign='top'>{$week}</td>\n";
				if ($weekNumber == $thisWeek) {
					$style = "smCalendarThisWeek";
					$thisDayStyle = "smCalendarThisWeek smCalendarThisDay";
				} else {
					$style = $thisDayStyle = "smCalendarDay";
				}
			}
			
			$key = sprintf("%04d-02d-02d", $year, $month, $i);

			$rc .= sprintf(
				"\t<td class='smCalendarCell %s%s' valign='top'><span class='smCalendarNumber'>%d</span></td>\n", 
				$i == $thisDate['mday'] ? $thisDayStyle : $style, 
				$weekDay < 5 ? "" : " smCalendarWeekend", $i
			);
		}

		for ( ; $weekDay != 0; $weekDay = ($weekDay + 1) % 7) {
			$rc .= sprintf(
				"\t<td class='smCalendarCell %s'>&nbsp;</td>\n", 
				$weekDay < 5 ? "smCalendarDay" : "smCalendarWeekend"
			);
		}

		$rc .= "</tr>\n</table>\n";

		return $rc;		
	} 
	
	/*
	 * $obj->getLargeCalendar($notes)
	 * Date::getLargeCalendar($notes, $year, $month)
	 */
	function getLargeCalendar(/* $notes [, $year, $month] */)
	{
		switch (func_num_args()) {
		case 3:
			$notes = func_get_arg(0);
			$year = func_get_arg(1);
			$month = func_get_arg(2);
			break;
		case 1:
			$notes = func_get_arg(0);
			$year = $this->date['year'];
			$month = $this->date['mon'];
			break;
		default:
			return '';
		}
		
		$name = date('F', mktime(0,0,0,$month,1,$year));
		$weekNumber = Date::getWeekNumber($year, $month, 1);
		$daysInMonth = Date::getDaysInMonth($year, $month);	
		$weekDay = Date::getFirstWeekDayOfMonth($year, $month) - 1;

		$thisDate = getdate(time());
		$thisDay = mktime(0, 0, 0, $thisDate['mon'], $thisDate['mday'], $thisDate['year']);
		$thisWeek = Date::getWeekNumber($thisDate['year'], $thisDate['mon'], $thisDate['mday']);

		if ($year != $thisDate['year']) {
			$thisWeek = 0;
		}
	
		$rc = <<<EOT
<table class="lgCalendarTable">
<tr>
	<td class="lgCalendarCell lgCalendarMonthTitle" colspan="8" align="center">{$name} &nbsp; {$year}</td>
</tr>
<tr>
	<td class="lgCalendarCell lgCalendarDayTitle" width="2%">W</td>
	<td class="lgCalendarCell lgCalendarDayTitle" width="14%">Mo</td>
	<td class="lgCalendarCell lgCalendarDayTitle" width="14%">Tu</td>
	<td class="lgCalendarCell lgCalendarDayTitle" width="14%">We</td>
	<td class="lgCalendarCell lgCalendarDayTitle" width="14%">Th</td>
	<td class="lgCalendarCell lgCalendarDayTitle" width="14%">Fr</td>
	<td class="lgCalendarCell lgCalendarDayTitle" width="14%">Sa</td>
	<td class="lgCalendarCell lgCalendarDayTitle" width="14%">Su</td>
</tr>
<tr>
	<td class="lgCalendarCell lgCalendarWeekNumber" valign='top' style='padding-left: 0; padding-right: 1;'><img align='left' width='1' height='80' src='pixel.gif'>{$weekNumber}</td>

EOT;

		if ($weekNumber == $thisWeek) {
			$style = "lgCalendarThisWeek";
			$thisDayStyle = "lgCalendarThisWeek lgCalendarThisDay";
		} else {
			$style = $thisDayStyle = "lgCalendarDay";
		}
		
		for ($i = 0; $i < $weekDay; $i++) {
			$rc .= sprintf(
				"\t<td class='lgCalendarCell %s%s'>&nbsp;</td>\n", 
				$i == $thisDate['wday'] ? $thisDayStyle : $style, 
				$i < 5 ? "" : " lgCalendarWeekend"
			);
		}
	
		for ($i = 1; $i <= $daysInMonth; $i++, $weekDay = ($weekDay + 1) % 7) {
			if (1 < $i && $weekDay == 0) {
				$weekNumber = Date::getWeekNumber($year, $month, $i);

				$week = $weekNumber < 10 ? "&nbsp;&nbsp;{$weekNumber}" : $weekNumber;
				$rc .= "</tr>\n<tr>\n\t<td class='lgCalendarCell lgCalendarWeekNumber' valign='top' style='padding-left: 0; padding-right: 1;'><img align='left' width='1' height='80' src='pixel.gif'>{$week}</td>\n";
				if ($weekNumber == $thisWeek) {
					$style = "lgCalendarThisWeek";
					$thisDayStyle = "lgCalendarThisWeek lgCalendarThisDay";
				} else {
					$style = $thisDayStyle = "lgCalendarDay";
				}
			}
			
			$key = sprintf("%04d-%02d-%02d", $year, $month, $i);

			$rc .= sprintf(
				"\t<td class='lgCalendarCell %s%s' valign='top' style='text-align: left;'><span class='lgCalendarNumber'>%d&nbsp;&nbsp;</span>%s</td>\n", 
				$i == $thisDate['mday'] ? $thisDayStyle : $style, 
				$weekDay < 5 ? "" : " lgCalendarWeekend",
				$i, isset($notes[$key]) ? $notes[$key] : ''
			);

		}

		for ( ; $weekDay != 0; $weekDay = ($weekDay + 1) % 7) {
			$rc .= sprintf(
				"\t<td class='lgCalendarCell %s'>&nbsp;</td>\n", 
				$weekDay < 5 ? "lgCalendarDay" : "lgCalendarWeekend"
			);
		}

		$rc .= "</tr>\n</table>\n";

		return $rc;		
	} 	
}
?>