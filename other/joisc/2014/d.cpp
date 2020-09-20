#include <algorithm>
#include <iostream>
#include <string>
#include <vector>
#include "ramen.h"

using namespace std;

template <class T>ostream &operator<<(ostream &o,const vector<T>&v)
{o<<"{";for(int i=0;i<(int)v.size();i++)o<<(i>0?", ":"")<<v[i];o<<"}";return o;}

int Compare(int X, int Y) {
    return 1;
}

void Answer(int X, int Y) {

}

void Ramen(int N) {
    vector<int> hs, ls;
    for (int i = 1; i+1 < N; i += 2) {
        if (Compare(i, i+1) == 1) {
            hs.push_back(i);
            ls.push_back(i+1);
        } else {
            hs.push_back(i+1);
            ls.push_back(i);
        }
    }
    int h = 0, l = 0;
    if (N%2 == 0) {
        if (Compare(0, N-1) == 1) {
            l = N-1;
        } else {
            h = N-1;
        }
    }

    for (auto j: hs) {
        if (Compare(h, j) == -1) {
            h = j;
        }
    }
    for (auto j: ls) {
        if (Compare(l, j) == 1) {
            l = j;
        }
    }

    Answer(l, h);
}

int main() {
    Ramen(10);
    return 0;
}