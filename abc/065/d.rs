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

struct UnionFind {
    tree: Vec<usize>,
    rank: Vec<usize>,
}

impl UnionFind {
    fn new(n: usize) -> UnionFind {
        UnionFind {
            tree : (0..n).collect::<Vec<_>>(),
            rank : vec![0;n],
        }
    }

    fn parent(&mut self, x: usize) -> usize {
        if x == self.tree[x] {
            x
        } else {
            let p = self.tree[x];
            let q = self.parent(p);
            self.tree[x] = q;
            q
        }
    }

    fn is_same(&mut self, a: usize, b: usize) -> bool {
        self.parent(a) == self.parent(b)
    }

    fn unite(&mut self, a: usize, b: usize) -> bool {
        let a = self.parent(a);
        let b = self.parent(b);
        if a == b {
            return false;
        }

        if self.rank[a] > self.rank[b] {
            self.tree[b] = a;
        } else {
            self.tree[a] = b;
            if self.rank[a] == self.rank[b] {
                self.rank[b] += 1;
            }
        }
        true
    }
}

use std::cmp::Ordering;
use std::collections::BinaryHeap;

#[derive(Copy, Clone, Eq, PartialEq)]
struct Road {
    a: usize,
    b: usize,
    c: i64
}

impl Ord for Road {
    fn cmp(&self, other: &Road) -> Ordering {
        other.c.cmp(&self.c)
    }
}

impl PartialOrd for Road {
    fn partial_cmp(&self, other: &Road) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

fn main() {
    let n = get!(usize);
    let mut xx = Vec::new();
    let mut yy = Vec::new();
    for i in 0..n {
        let (x, y) = get!(usize, usize);
        xx.push((i, x));
        yy.push((i, y));
    }
    xx.sort_by(|&(_, a), &(_, b)| a.cmp(&b));
    yy.sort_by(|&(_, a), &(_, b)| a.cmp(&b));

    let mut pq = BinaryHeap::new();

    for i in 1..n {
        let (x1, j) = xx[i-1];
        let (x2, k) = xx[i];
        pq.push(Road { a: x1, b: x2, c: (k-j) as i64 });
        let (y1, j) = yy[i-1];
        let (y2, k) = yy[i];
        pq.push(Road { a: y1, b: y2, c: (k-j) as i64 });
    }

    let mut uft = UnionFind::new(n);
    let mut cost = 0;
    while let Some(Road { a, b, c }) = pq.pop() {
        if !uft.is_same(a, b) {
            cost += c;
            uft.unite(a, b);
        }
    }
    println!("{}", cost);
}