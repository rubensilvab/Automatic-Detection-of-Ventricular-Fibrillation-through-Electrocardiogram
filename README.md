# Automatic Detection of Ventricular Fibrillation through Electrocardiogram

Please be aware that numerous variations and experiments were conducted during this study. However, only the automatic method that yielded the most favorable outcome has been included in this summary of the work. To access the entire study, please read the full [report](Projeto_Rúben_93203.pdf) (portuguese).

## Motivation

According to the National Health Service (SNS), heart diseases continue to be the leading cause of death in Portugal, accounting for more than 35 thousand annual deaths in our country. These numbers reflect about one-third of the total annual national mortalities, highlighting an extreme concern in this area. 
Nevertheless, the inevitability of these cardiac problems occurring compels society to seek new solutions to prevent further fatal cases. Ventricular fibrillation is an emergency condition where the heart rate is uncontrolled and extremely high. Therefore, this work is based on the construction of an algorithm capable of detecting ventricular fibrillation by exploiting ECG characteristics. 

## Goals
- **Main Goal**: Construction of an algorithm capable of detecting ventricular fibrillation by exploiting ECG characteristics.
- Study the literature and extract some promising metrics for ventricular fibrillation.
- Reviewing and analyse these metrics independently.
- Multivariate analysis in order to enhance the discriminatory power of these metrics.
- Study the influence of metrics by using an unsupervised learning to verify if the data was grouped according to the two different conditions.
- Implement a supervised learning to automatically identify ventricular fibrillation events.  


## Methods

In this chapter, we will discuss how the entire algorithm was developed, including the following processes: signal filtering, selection and extraction of metrics, selection of time windows for metric calculation, evaluation of metrics, and classification methodology. Figure 1 schematically represents the different phases of the defined algorithm.

![workflow](https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/68c425f8-1d85-4973-9b53-257e6c6716b5)

 **Figure 1.**          *Workflow of the algorithm proposed (Preprocess -> feature extraction -> Statistical Analysis(boxplot/Hypothesis test) -> Classification)*



### Dataset 

The chosen database for this project is the CU Ventricular Tachyarrhythmia Database available on the Physionet website [^1]. It comprises 35 ECGs from patients experiencing periods of ventricular tachycardia and ventricular fibrillation. Each ECG was sampled at 250 Hz for approximately 8.5 minutes, corresponding to 127,232 samples. The signals have been pre-processed with a second-order low-pass filter with a cutoff frequency of 70 Hz. Importantly, each subject's ECG includes annotations indicating the electrocardiogram's state, including episodes of ventricular fibrillation.

To ensure a balance between participant quantity and the number of samples with the pathology, a selection process was conducted. Twenty-five subjects were chosen, each with at least 10,000 samples (40 seconds) for each episode of fibrillation and without fibrillation (control group). This approach maintains a considerable number of participants while preserving essential ECG signal information.

### Preprocessing

Preprocessing involves attenuating all irrelevant information from the signal that contaminates and prevents an accurate assessment of it. This irrelevant information is commonly referred to as noise.

#### Electrical network interference

The ECG of an individual is obtained by placing electrodes in specific areas of the human body. These electrodes detect ionic flow within the body by measuring the potential difference between them, making the correct direction and placement crucial for good visualization and ECG acquisition. In most cases, one electrode serves as a reference (ground) and is connected to an amplifier, which amplifies the signal in common mode corresponding to electrical network interference, typically at a fundamental frequency of about 50/60 Hz. To address this, it's necessary to construct a filter to remove these 60 Hz harmonics and artifacts.

Through various studies, it has been proven that the zero-phase in radians per sample corresponds to the frequency that the filter rejects, where the gain is lower. Conversely, the pole-phase defines the frequencies with higher gain. Therefore, to remove interference from the electrical grid, which has a frequency of 60 Hz, it suffices to set the phase in normalized angular frequency (radians per sample) of the zero corresponding to the 60 Hz frequency (Figure 2).

- The calculation performed corresponds to the conversion into normalized angular frequency, which is (60/Fa) * 2π, as w = 2πf. The division by the sampling frequency is due to the signal digitization.

  <img width="1171" alt="filtro60" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/c3f36bc4-d38d-47a7-adf0-381a6835a09c">

**Figure 2.**          *Map of poles and zeros of the filter and Frequency reponse*
  

![rede_eletrica](https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/dd60cc80-d7d4-4740-a777-25609fe61b93)

**Figure 3.**          *Application of the filter*

Although the difference is not as evident, we can observe a reduction in the small oscillations in the lower graph compared to the upper one, where the signal is not filtered (Figure 3).

#### Baseline Correction

The original ECG often shows low-frequency oscillations in its baseline, possibly due to patient movement or breathing. These oscillations, with frequencies around 0.15 to 0.3 Hz, need removal before analyzing the biosignal. A moving average filter can effectively eliminate this noise. First, average the 200 ms PR interval samples. Then, repeat for subsequent 200 ms samples until the signal's end. Use these averages as input for a similar procedure with 600 ms intervals, continuously until the signal's end.

![correçao_linhadebase](https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/b6f0e31d-3f31-4340-bef5-2e4874dabb26)

**Figure 5.**          *Effect of the moving average filter*

### Feature Extraction

#### Introduction to spectral domain analysis

Our database is defined in the time domain since the signal was acquired and recorded over time with a sampling frequency of 250 samples per second. However, we know that it is possible to convert and analyze the signal in the spectral domain using the discrete Fourier transform.

<img width="889" alt="fourier" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/7b15fe71-c5cb-4c0e-aa1f-98cf4068adf4">

**Equation 1.**          *Where X(k) represents the N coefficients in the frequency domain and 2𝛱/N, the frequency resolution in radians/sample.*

<img width="1175" alt="fourierex" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/c6c17059-2fab-4476-b04d-33a523e4092a">

**Figure 6.**          *Presentation of the signals in the time domain on the left side and in the spectral domain on the right side for the control ECG without pathology and the ECG with pathology. Note: VF-Ventricular Fibrillation.*

The analysis of Power Spectral Density (PSD) is a very useful and common procedure in various biomedical signals. One way to estimate this measure is by calculating the square of the absolute value of the Fast Fourier Transform (FFT). There are several methods to calculate and obtain the PSD, all of which are based on the periodogram.

A Welch Power Spectral Density is calculated by averaging periodograms. Firstly, the signal is divided into K segments, each with M samples. However, most of the time these segments have a certain percentage of overlap. Then, each segment is multiplied by a window function w(n) (such as Hamming, Hann, Kaiser, Rectangular, etc.). Only after these steps are applied to a segment, it undergoes Fourier transformation and the respective periodogram calculation.

<img width="856" alt="perio" src="https://github.com/rubensilvab/Automatic-Detection-of-Ventricular-Fibrillation-through-Electrocardiogram/assets/130314085/dc145d94-9ece-4c8b-8ac7-e63efb2aee2d">

**Equation 2.** *The average of the periodograms over the total number of segments K.*

[^1]: Goldberger, A., L. Amaral, L. Glass, J. Hausdorff, P. C. Ivanov, R. Mark, J. E. Mietus, G. B. Moody, C. K. Peng, and H. E. Stanley. "PhysioBank, PhysioToolkit, and PhysioNet: Components of a new research resource for complex physiologic signals. Circulation [Online]. 101 (23), pp. e215–e220." (2000).
