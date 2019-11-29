import std.stdio, std.algorithm, std.conv, std.array, std.string;

long N = 10 ^^ 9 + 7;
int[10 ^^ 5 + 1] CS;

long comb(long r, long n)
{
    long p = 1;

    foreach (i; 0..r)
        p = (p * (n - i) / (i + 1)) % N;

    return p;
}

void main()
{
    auto n = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);

    int dupl;
    int before, after;

    foreach (i; 0..n + 1) {
        if (CS[as[i]]) {
            dupl = as[i];
            break;
        }
        ++CS[as[i]];
    }
    int cnt;
    foreach (i; 0..n + 1) {
        if (as[i] == dupl) {
            
        }
        if (CS[as[i]] == 2) {
            
        }
        ++cnt;
        ++CS[as[i]];
    }
    
    foreach (i; 0..n) {
        long sum;
        foreach (j; 0..(n - i)) {

        }
    }
}