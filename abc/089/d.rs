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
    let (h, w, d) = get!(usize, usize, usize);
    let mut aa = vec![(0_i64, 0_i64); h*w+1];
    for i in 0..h {
        let a = get!(String).split_whitespace().map(|c| c.parse::<usize>().unwrap()).collect::<Vec<_>>();
        for j in 0..w {
            aa[a[j]] = (i as i64, j as i64);
        }
    }
    let mut dd = vec![0; h*w+1];
    for x in 1..d+1 {
        let (mut i, mut j) = aa[x];
        let mut xx = x;
        let mut last_d = 0;
        loop {
            xx += d;
            if xx > h*w { break; }
            let (ii, jj) = aa[xx];
            last_d += (i - ii).abs() + (j - jj).abs();
            dd[xx] = last_d;
            i = ii;
            j = jj;
        }
    }
    let q = get!(usize);
    for _ in 0..q {
        let (l, r) = get!(usize, usize);
        println!("{}", dd[r] - dd[l]);
    }
}