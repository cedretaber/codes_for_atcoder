import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto hwhw = readln.split.to!(int[]);
    auto H = hwhw[0];
    auto W = hwhw[1];
    auto h = hwhw[2];
    auto w = hwhw[3];

    auto hw = new int[W][H];

    long sum_rec(int hh, int ww) {
        long sum;
        foreach (ls; hw[hh..hh+h]) {
            foreach (e; ls[ww..ww+w]) {
                
            }
        }
    }

    foreach (j; 0..H-h) {
        foreach (i; 0..W-w) {

        }
    }
}