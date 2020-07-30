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

fn main() {
    let n = get!(usize);
    let mut aa = get!(String).split_whitespace().map(|i| i.parse::<i32>().unwrap()).collect::<Vec<_>>();
    aa.sort();
    let bb = get!(String).split_whitespace().map(|i| i.parse::<i32>().unwrap()).collect::<Vec<_>>();
    let mut cc = get!(String).split_whitespace().map(|i| i.parse::<i32>().unwrap()).collect::<Vec<_>>();
    cc.sort();

    let mut s = 0;
    for b in bb.into_iter() {
        let mut l;
        let mut r;
        let x = if aa[0] >= b {
            0
        } else {
            l = 0;
            r = n;
            while l+1 < r {
                let m = (l+r)/2;
                if aa[m] < b {
                    l = m;
                } else {
                    r = m;
                }
            }
            r
        };
        let y = if cc[0] > b {
            n
        } else {
            l = 0;
            r = n;
            while l+1 < r {
                let m = (l+r)/2;
                if cc[m] <= b {
                    l = m;
                } else {
                    r = m;
                }
            }
            n - r
        };
        s += x * y;
    }
    println!("{}", s);
}