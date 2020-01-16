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
    ($t:ty ;;) => {
        {
            let mut line: String = String::new();
            std::io::stdin().read_line(&mut line).unwrap();
            line.split_whitespace()
                .map(|t| t.parse::<$t>().unwrap())
                .collect::<Vec<_>>()
        }
    };
    ($t:ty ;; $n:expr) => {
        (0..$n).map(|_| get!($t ;;)).collect::<Vec<_>>()
    };
}

struct UnionFind {
    par: Vec<usize>,
    rank: Vec<usize>,
}

impl UnionFind {
    fn new(n: usize) -> UnionFind {
        let mut vec = vec![0;n];
        for i in 0..n {
            vec[i] = i;
        }
        UnionFind {
            par : vec,
            rank : vec![0;n],
        }
    }

    fn find(&mut self, x: usize) -> usize {
        if x == self.par[x] {
            x
        }else{
            let par = self.par[x];
            let res = self.find(par);
            self.par[x] = res;
            res
        }
    }

    fn same(&mut self, a: usize, b: usize) -> bool {
        self.find(a) == self.find(b)
    }

    fn unite(&mut self, a: usize, b: usize){
        let apar = self.find(a);
        let bpar = self.find(b);
        if self.rank[apar] > self.rank[bpar] {
            self.par[bpar] = apar;
        } else {
            self.par[apar] = bpar;
            if self.rank[apar] == self.rank[bpar] {
                self.rank[bpar] += 1;
            }
        }
    }
}

use std::collections::HashMap;

fn main() {
    let (n, k, l) = get!(usize, usize, usize);
    let mut kq = UnionFind::new(n);
    let mut lq = UnionFind::new(n);
    for _ in 0..k {
        let (p, q) = get!(usize, usize);
        kq.unite(p-1, q-1);
    }
    for _ in 0..l {
        let (r, s) = get!(usize, usize);
        lq.unite(r-1, s-1);
    }
    let mut map = HashMap::new();
    for i in 0..n {
        let key = (kq.find(i), lq.find(i));
        let x = map.entry(key).or_insert(0);
        *x += 1;
    }
    let mut ans = Vec::new();
    for i in 0..n {
        let key = (kq.find(i), lq.find(i));
        if let Some(x) = map.get(&key) {
            ans.push(x.to_string());
        }
    }
    println!("{}", ans.join(" "));
}