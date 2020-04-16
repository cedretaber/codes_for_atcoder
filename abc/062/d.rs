macro_rules! get {
    ($t:ty) => {
        {
            let mut line: String = String::new();
            std::io::stdin().read_line(&mut line).unwrap();
            line.trim().parse::<$t>().unwrap()
        }
    };
    ($($t:ty),*) => {
        {
            let mut line: String = String::new();
            std::io::stdin().read_line(&mut line).unwrap();
            let mut iter = line.split_whitespace();
            (
                $(iter.next().unwrap().parse::<$t>().unwrap(),)*
            )
        }
    };
    ($t:ty; $n:expr) => {
        (0..$n).map(|_|
            get!($t)
        ).collect::<Vec<_>>()
    };
    ($($t:ty),*; $n:expr) => {
        (0..$n).map(|_|
            get!($($t),*)
        ).collect::<Vec<_>>()
    };
}

use std::cmp::Ordering;

#[derive(Eq, PartialEq, Clone, Debug)]
pub struct Rev<T>(pub T);

impl<T: PartialOrd> PartialOrd for Rev<T> {
    fn partial_cmp(&self, other: &Rev<T>) -> Option<Ordering> {
        other.0.partial_cmp(&self.0)
    }
}

impl<T: Ord> Ord for Rev<T> {
    fn cmp(&self, other: &Rev<T>) -> Ordering {
        other.0.cmp(&self.0)
    }
}

use std::collections::BinaryHeap;
use std::cmp;

fn main() {
    let n = get!(usize);
    let aa = get!(String).split_whitespace().map(|i| i.parse::<i64>().unwrap()).collect::<Vec<_>>();

    let mut sa = vec![0; n*3];
    let mut sh = BinaryHeap::new();
    let mut a: i64 = 0;
    for i in 0..n {
        a += aa[i];
        sh.push(Rev(aa[i]));
        sa[i] = a;
    }
    for ii in 0..n {
        let i = n + ii;
        a += aa[i];
        sh.push(Rev(aa[i]));
        if let Some(Rev(b)) = sh.pop() {
            a -= b;
        }
        sa[i] = a;
    }
    let mut ea = vec![0; n*3];
    let mut eh = BinaryHeap::new();
    a = 0;
    for ii in 0..n {
        let i = n*3 - ii - 1;
        a += aa[i];
        eh.push(aa[i]);
        ea[i] = a;
    }
    for ii in 0..n {
        let i = n*2 - ii - 1;
        a += aa[i];
        eh.push(aa[i]);
        if let Some(b) = eh.pop() {
            a -= b;
        }
        ea[i] = a;
    }

    let mut r = i64::min_value();
    for i in n-1..n*2 {
        r = cmp::max(r, sa[i] - ea[i+1]);
    }
    println!("{}", r);
}