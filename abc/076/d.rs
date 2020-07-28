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

use std::cmp;

fn main() {
    let n = get!(usize);
    let mut ts = get!(String).split_whitespace().map(|i| i.parse::<usize>().unwrap() * 2).collect::<Vec<_>>();
    for i in 1..n {
        ts[i] += ts[i-1];
    }
    let vs = get!(String).split_whitespace().map(|i| i.parse::<usize>().unwrap() * 2).collect::<Vec<_>>();

    let &t_sum = ts.last().unwrap();
    let &v_max = vs.iter().max().unwrap();

    let mut tt = vec![v_max+1; t_sum+1];

    for i in 0..n {
        let s = if i == 0 { 0 } else { ts[i-1]+1 };
        for j in s..ts[i]+1 {
            tt[j] = cmp::min(tt[j], vs[i]);
        }
    }

    for i in 0..cmp::min(t_sum, v_max)+1 {
        tt[i] = cmp::min(tt[i], i);
    }
    for i in 0..n {
        let mut j = ts[i];
        let mut k = vs[i];
        loop {
            if j > t_sum || k > v_max {
                break;
            }
            tt[j] = cmp::min(tt[j], k);
            j += 1;
            k += 1;
        }
    }
    let mut j = t_sum;
    let mut k = 0;
    loop {
        tt[j] = cmp::min(tt[j], k);
        if j == 0 || k == v_max {
            break;
        }
        j -= 1;
        k += 1;
    }
    for i in 0..n-1 {
        let mut j = ts[i];
        let mut k = vs[i+1];
        if k > v_max {
            break;
        }
        loop {
            tt[j] = cmp::min(tt[j], k);
            if j == 0 || k == v_max {
                break;
            }
            j -= 1;
            k += 1;
        }
    }

    let mut s = 0;
    for i in 0..t_sum+1 {
        s += tt[i];
    }
    println!("{:.12}", (s as f64) / 4.0);
}