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

fn search(i: usize, p: usize, t: usize, g: &Vec<Vec<usize>>, mut m: &mut Vec<bool>) -> bool {
    for &j in g[i].iter() {
        if j == p || m[j] { continue; }
        if j == t { return true; }
        m[j] = true;
        if search(j, i, t, g, &mut m) { return true; }
    }
    return false;
}

fn main() {
    let (n, m) = get!(usize, usize);
    let mut g = vec![Vec::new(); n];
    let mut aa = Vec::new();
    let mut bb = Vec::new();
    for _ in 0..m {
        let (a, b) = get!(usize, usize);
        g[a-1].push(b-1);
        g[b-1].push(a-1);
        aa.push(a-1);
        bb.push(b-1);
    }

    let mut r = 0;
    for s in 0..m {
        let mut memo = vec![false; n];
        memo[aa[s]] = true;
        if !search(aa[s], bb[s], bb[s], &g, &mut memo) { r += 1; };
    }
    println!("{}", r);
}